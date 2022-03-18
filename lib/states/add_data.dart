// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shareqrcode/models/favorite_link_model.dart';
import 'package:shareqrcode/models/product_model.dart';
import 'package:shareqrcode/states/confirm_data.dart';
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

  @override
  void initState() {
    super.initState();
    findUserData();
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text('Add Data'),
      ),
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
                  newDropBox(context),
                  const ShowSizeBox(),
                  listItemChoose(),
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
          print('string = $string');

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
}
