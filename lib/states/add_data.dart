// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shareqrcode/models/category_model.dart';
import 'package:shareqrcode/models/favorite_link_model.dart';
import 'package:shareqrcode/models/product_model.dart';
import 'package:shareqrcode/states/confirm_data.dart';
import 'package:shareqrcode/states/show_stock_link.dart';
import 'package:shareqrcode/utility/my_constant.dart';
import 'package:shareqrcode/utility/my_dialog.dart';
import 'package:shareqrcode/widgets/show_form.dart';
import 'package:shareqrcode/widgets/show_image.dart';
import 'package:shareqrcode/widgets/show_sizebox.dart';
import 'package:shareqrcode/widgets/show_text.dart';
import 'package:shareqrcode/widgets/showbutton.dart';

class AddData extends StatefulWidget {
  const AddData({
    Key? key,
  }) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  String? uidLogin, nameItem, urlItem, nameProduct, detailProduct;
  var itemDropdowns = <String>[];
  var favoriteLinkModels = <FavoriteLinkModel>[];
  String? chooseItemDropdown, tempChooseItem;
  var tempChooseItems = <String>[];
  var tempChooseItemsModels = <FavoriteLinkModel>[];
  File? file;
  var photoPaths = <String>[];
  var files = <File>[];

  var categoryModels = <CategoryModel>[];
  var itemCategorys = <String>[];

  String? chooseCategory;
  String? addNewCatStr;
  // var chooseCategoryModels = <CategoryModel>[];
  var chooseCategorys = <String>['สาธารณะ'];

  @override
  void initState() {
    super.initState();
    findUserData();
    findCategory();
  }

  Future<void> findCategory() async {
    if (categoryModels.isNotEmpty) {
      categoryModels.clear();
      itemCategorys.clear();
    }
    await FirebaseFirestore.instance
        .collection('category')
        .orderBy('name')
        .get()
        .then((value) {
      for (var item in value.docs) {
        CategoryModel categoryModel = CategoryModel.fromMap(item.data());
        // print('#23mar name Cat ==>> ${categoryModel.name}');
        categoryModels.add(categoryModel);
        itemCategorys.add(categoryModel.name);
      }

      itemCategorys.add('+ Add New Category');

      setState(() {});
    });
  }

  Future<void> processTakePhoto(ImageSource source) async {
    var result = await ImagePicker()
        .pickImage(source: source, maxWidth: 800, maxHeight: 800);
    setState(() {
      file = File(result!.path);
      files.add(File(result.path));
    });
  }

  Future<void> findUserData() async {
    if (itemDropdowns.isNotEmpty) {
      itemDropdowns.clear();
      favoriteLinkModels.clear();
    }

    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      uidLogin = event!.uid;

      await FirebaseFirestore.instance
          .collection('dataCode')
          .doc(uidLogin)
          .collection('favoritlink')
          .get()
          .then((value) {
        for (var item in value.docs) {
          FavoriteLinkModel favoriteLinkModel =
              FavoriteLinkModel.fromMap(item.data());
          itemDropdowns.add(favoriteLinkModel.nameItem);
          favoriteLinkModels.add(favoriteLinkModel);
        }
        itemDropdowns.add('+ Add New Item');

        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: newAppBar(context),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: SingleChildScrollView(
            child: LayoutBuilder(builder: (context, constraints) {
              return Column(
                children: [
                  const ShowSizeBox(),
                  newTitle(),
                  const ShowSizeBox(),
                  ShowForm(
                      label: 'ชื่อสินค้า',
                      changeFunc: (String string) =>
                          nameProduct = string.trim()),
                  const ShowSizeBox(),
                  ShowForm(
                      label: 'รายละเอียดสินค้า',
                      changeFunc: (String string) =>
                          detailProduct = string.trim()),
                  const ShowSizeBox(),
                  categoryModels.isEmpty
                      ? const SizedBox()
                      : dropBoxCategory(context),
                  chooseCategorys.isEmpty
                      ? const SizedBox()
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: chooseCategorys.length,
                          itemBuilder: (context, index) => ListTile(
                            title: ShowText(
                              label: chooseCategorys[index],
                            ),
                            trailing: chooseCategorys[index] == 'สาธารณะ'
                                ? const SizedBox()
                                : IconButton(
                                    onPressed: () {
                                      chooseCategorys.removeAt(index);
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.delete_forever)),
                          ),
                        ),
                  // newDropBox(context),
                  const ShowSizeBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShowForm(
                        label: 'ชื่อลิ้งค์',
                        changeFunc: (String string) {},
                        width: 150,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      ShowForm(
                        label: 'ลิ้งค์',
                        changeFunc: (String string) {},
                        width: 150,
                      ),
                      ShowButton(
                          label: 'OK',
                          pressFunc: () {
                            MyDialog(context: context).discusDialog(
                                'Item or Save ?',
                                'คุณต้องการ Show Item และ เก็บข้อมูล',
                                'Save And Show',
                                'Save Only',
                                () => null,
                                () => null);
                          }),
                    ],
                  ),
                  ShowButton(
                    label: 'Stock Link',
                    pressFunc: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShowStockLink(),
                      ),
                    ),
                  ),
                  // listItemChoose(),
                  const ShowSizeBox(),
                  SizedBox(
                    width: constraints.maxWidth * 0.8,
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            file == null
                                ? ShowImage(
                                    path: 'images/camera.png',
                                    width: constraints.maxWidth * 0.6,
                                  )
                                : SizedBox(
                                    width: constraints.maxWidth * 0.6,
                                    child: Image.file(
                                      file!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ],
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: IconButton(
                              onPressed: () async {
                                // processTakePhoto(ImageSource.camera);
                                MyDialog(context: context).chooseSourceDialog(
                                  cameraFunc: () {
                                    Navigator.pop(context);
                                    return processTakePhoto(ImageSource.camera);
                                  },
                                  galleryFunc: () {
                                    Navigator.pop(context);
                                    return processTakePhoto(
                                        ImageSource.gallery);
                                  },
                                );
                              },
                              icon: const Icon(Icons.add_a_photo_outlined)),
                        )
                      ],
                    ),
                  ),
                  const ShowSizeBox(
                    hight: 100,
                  )
                ],
              );
            }),
          ),
        ),
      ),
      floatingActionButton: confirmButton(context),
    );
  }

  DropdownButton<Object> dropBoxCategory(BuildContext context) {
    return DropdownButton(
        items: itemCategorys
            .map(
              (e) => DropdownMenuItem(
                child: ShowText(label: e),
                value: e,
              ),
            )
            .toList(),
        value: chooseCategory,
        hint: const ShowText(label: 'กรุณาเลือก กลุ่ม'),
        onChanged: (value) {
          if (value == '+ Add New Category') {
            // print('#23mar you Click Add Cat');
            MyDialog(context: context).categoryAddDialog(
              changeFunc: (String string) {
                addNewCatStr = string.trim();
              },
              addCatFunc: () {
                Navigator.pop(context);
                if (addNewCatStr?.isEmpty ?? true) {
                  MyDialog(context: context).normalDialog(
                      'No Category',
                      'Please Fill Category',
                      'OK',
                      () => Navigator.pop(context),
                      'images/logo.png');
                } else {
                  processCheckAndAddCategory();
                }
              },
            );
          } else {
            // สิีงที่ต้องแก้พรุ่งนี้

            print('#24mar ก่อน chooseCatetorys ==> $chooseCategorys');

            if (chooseCategorys.isEmpty) {
              chooseCategorys.add(value.toString());
            } else {
              bool check = true; // true ==> ตัว Category ไม่มีการซ้ำ
              for (var item in chooseCategorys) {
                if (item == value.toString()) {
                  check = false;
                }
              }

              if (check) {
                chooseCategorys.add(value.toString());
                // check = true;
              } else {
                MyDialog(context: context).normalDialog(
                    'Catetory ซำ้',
                    'เลือกใหม่ Cat ซ้ำ',
                    'OK',
                    () => Navigator.pop(context),
                    'images/logo.png');
              }
            }
            print('#24mar หลัง chooseCatetorys ==> $chooseCategorys');
            setState(() {});
          }
        });
  }

  AppBar newAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, MyConstant.routeHome, (route) => false),
          icon: const Icon(Icons.arrow_back)),
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      title: const Text('Add Data'),
    );
  }

  ShowButton confirmButton(BuildContext context) {
    return ShowButton(
      label: 'Confirm Data',
      pressFunc: () async {
        if ((nameProduct?.isEmpty ?? true) ||
            (detailProduct?.isEmpty ?? true)) {
          MyDialog(context: context).normalDialog(
              'กรอกข้อมูล ไม่ครบ',
              'กรอก ชื่อสินค้า และ รายละเอียดให้ครบ',
              'OK',
              () => Navigator.pop(context),
              'images/image3.png');
        } else if (tempChooseItems.isEmpty) {
          MyDialog(context: context).normalDialog(
              'ยังไม่เลือก Item',
              'กรุณาเลือก Item ด้วย คะ',
              'OK',
              () => Navigator.pop(context),
              'images/image2.png');
        } else {
          var tempChooseUrllinks = <String>[];
          for (var item in tempChooseItems) {
            String string = findUrlink(item);
            tempChooseUrllinks.add(string);
          }

          String qrCode = uidLogin!.substring(0, 4);
          qrCode = '$qrCode${Random().nextInt(1000000)}';

          ProductModel productModel = ProductModel(
            nameProduct: nameProduct!,
            detailProduct: detailProduct!,
            titleItems: tempChooseItems,
            linkItems: tempChooseUrllinks,
            pathImages: photoPaths,
            qrCode: qrCode,
            timestamp: Timestamp.fromDate(DateTime.now()),
            post: false,
            categorys: [],
          );

          if (files.isNotEmpty) {
            if (photoPaths.isNotEmpty) {
              photoPaths.clear();
            }
            for (var item in files) {
              String nameFile = 'product${Random().nextInt(1000000)}.jpg';
              FirebaseStorage storage = FirebaseStorage.instance;
              Reference reference = storage.ref().child('product/$nameFile');
              UploadTask uploadTask = reference.putFile(item);
              await uploadTask.whenComplete(() async {
                await reference
                    .getDownloadURL()
                    .then((value) => photoPaths.add(value));
              });
            }
          }

          print('#18mar files.lenght ==> ${files.length}');
          print('#18mar productModel ==> ${productModel.toMap()}');

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConfirmData(
                  productModel: productModel,
                ),
              ));
        }
      },
    );
  }

  StatelessWidget listItemChoose() {
    return tempChooseItems.isEmpty
        ? const ShowSizeBox()
        : ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: tempChooseItems.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShowText(label: tempChooseItems[index]),
                  const ShowSizeBox(),
                  // ShowText(
                  //   label: findUrlink(tempChooseItems[index]),
                  //   textStyle: MyConstant().h3BlueStyle(),
                  // ),
                  IconButton(
                    onPressed: () {
                      print('delete index = $index');
                      setState(() {
                        tempChooseItems.removeAt(index);
                      });
                    },
                    icon: const Icon(Icons.delete_forever_outlined),
                  ),
                ],
              ),
            ),
          );
  }

  DropdownButton<dynamic> newDropBox(BuildContext context) {
    return DropdownButton<dynamic>(
        hint: const ShowText(label: 'Please Choose Item'),
        value: chooseItemDropdown,
        items: itemDropdowns
            .map(
              (e) => DropdownMenuItem(
                child: ShowText(label: e),
                value: e,
              ),
            )
            .toList(),
        onChanged: (value) {
          String string = value;

          tempChooseItem = string;

          if (value == itemDropdowns[itemDropdowns.length - 1]) {
            print('Choose Add item');
            MyDialog(context: context).addNewItemDialog(
              title: 'เพิ่ม Item',
              message: 'กรุณากรอก ข้อมูลให้ครบทุกช่อง คะ',
              labelButton: 'Add Item',
              pathImage: 'images/image3.png',
              function: () {
                Navigator.pop(context);
                if ((nameItem?.isEmpty ?? true) || (urlItem?.isEmpty ?? true)) {
                  MyDialog(context: context).normalDialog(
                      'มีช่องว่าง ?',
                      'กรุณากรอก ให้ครบทุกช่อง คะ',
                      'OK',
                      () => Navigator.pop(context),
                      'images/image2.png');
                } else {
                  processAddNewItem();
                }
              },
              nameFunc: (String name) => nameItem = name.trim(),
              urlFunc: (String url) => urlItem = url.trim(),
            );
          } else {
            print('not choose Add item');
            setState(() {
              tempChooseItems.add(tempChooseItem!);
            });
            print('temtChooseItems ==>> $tempChooseItems');
          }
        });
  }

  ShowText newTitle() {
    return ShowText(
      label: 'เพิ่ม Product',
      textStyle: MyConstant().h2Style(),
    );
  }

  Future<void> processAddNewItem() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      String uidLogin = event!.uid;
      print('nameItem ==> $nameItem, urlItem = $urlItem, uidLogin = $uidLogin');

      FavoriteLinkModel favoriteLinkModel =
          FavoriteLinkModel(nameItem: nameItem!, urlItem: urlItem!);

      await FirebaseFirestore.instance
          .collection('dataCode')
          .doc(uidLogin)
          .collection('favoritlink')
          .doc()
          .set(favoriteLinkModel.toMap())
          .then((value) {
        print('Success add Item');
        findUserData();
      });
    });
  }

  String findUrlink(String tempChooseItem) {
    String urlItem = '';
    for (var item in favoriteLinkModels) {
      if (item.nameItem == tempChooseItem) {
        urlItem = item.urlItem;
      }
    }
    return urlItem;
  }

  Future<void> processCheckAndAddCategory() async {
    // print('#23mar addCat ==>> $addNewCatStr');
    bool check = true; // true ==> ไม่ซ้ำเลย
    for (var item in itemCategorys) {
      if (addNewCatStr == item) {
        check = false;
      }
    }

    if (check) {
      var user = FirebaseAuth.instance.currentUser;
      String owner = user!.uid;
      DateTime dateTime = DateTime.now();
      Timestamp timestamp = Timestamp.fromDate(dateTime);
      // print('#23mar owner ==> $owner');

      CategoryModel categoryModel =
          CategoryModel(name: addNewCatStr!, owner: owner, dateTime: timestamp);
      await FirebaseFirestore.instance
          .collection('category')
          .doc()
          .set(categoryModel.toMap())
          .then((value) {
        findCategory();
        setState(() {});
      });
    } else {
      MyDialog(context: context).normalDialog(
          'Category ซ้ำ',
          '$addNewCatStr มีอยู่แล้ว เปลี่ยนใหม่',
          'OK',
          () => Navigator.pop(context),
          'images/logo.png');
    }
  }
}
