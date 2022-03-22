// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart';
import 'package:shareqrcode/models/product_model.dart';
import 'package:shareqrcode/models/user_model.dart';
import 'package:shareqrcode/states/show_detail_qr_code.dart';
import 'package:shareqrcode/utility/my_constant.dart';
import 'package:shareqrcode/utility/my_dialog.dart';
import 'package:shareqrcode/widgets/show_avatar_follow.dart';
import 'package:shareqrcode/widgets/show_card_box.dart';
import 'package:shareqrcode/widgets/show_form.dart';
import 'package:shareqrcode/widgets/show_image.dart';
import 'package:shareqrcode/widgets/show_progress.dart';
import 'package:shareqrcode/widgets/show_sign_out.dart';
import 'package:shareqrcode/widgets/show_text.dart';
import 'package:shareqrcode/widgets/showbutton.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool? checkLogin;
  bool load = true;
  String? qrCode;

  var productModels = <ProductModel>[];
  var userModels = <UserModel>[];
  var docDataCodes = <String>[];

  @override
  void initState() {
    super.initState();
    processChcckLogin();
    readProduct();
  }

  Future<void> readProduct() async {
    await FirebaseFirestore.instance
        .collection('dataCode')
        .get()
        .then((value) async {
      for (var item in value.docs) {
        String docDataCode = item.id;
        UserModel userModel = UserModel.fromMap(item.data());

        await FirebaseFirestore.instance
            .collection('dataCode')
            .doc(item.id)
            .collection('product')
            .where('post', isEqualTo: true)
            .get()
            .then((value) {
          for (var item in value.docs) {
            // print('#21mar ${item.data()}');
            docDataCodes.add(docDataCode);
            userModels.add(userModel);
            ProductModel productModel = ProductModel.fromMap(item.data());
            productModels.add(productModel);
            print('#21mar post ==> ${productModel.post}');
          }
        });
      }
      setState(() {});
    });
  }

  Future<void> processChcckLogin() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event == null) {
        checkLogin = false;
      } else {
        checkLogin = true;
        // String? urlAvatar = event.photoURL;
        // print('urlAvatar ==>> $urlAvatar');
        // if (urlAvatar == null) {
        //   MyDialog(context: context).normalDialog('No Avatar',
        //       'คุณยังไม่มี รูป Profile', 'OK', () => null, 'images/image4.png');
        // }
      }
      setState(() {
        load = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: newAppBar(),
      body: LayoutBuilder(builder: (context, constraints) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
          behavior: HitTestBehavior.opaque,
          child: SingleChildScrollView(
            child: Column(
              children: [
                newWork(constraints),
                const ShowText(label: 'Category'),
                load
                    ? const ShowProgress()
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisExtent: 230,
                        ),
                        itemBuilder: (BuildContext context, int index) =>
                            InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShowDetailQRcode(productModel: productModels[index],),
                              )),
                          child: Card(
                            child: Column(
                              children: [
                                productModels[index].pathImages.isEmpty
                                    // ignore: prefer_const_constructors
                                    ? SizedBox(
                                        width: 150,
                                        height: 170,
                                        child: const ShowImage(
                                          path: 'images/logo.png',
                                        ),
                                      )
                                    : SizedBox(
                                        width: 150,
                                        height: 170,
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: productModels[index]
                                              .pathImages[0],
                                          placeholder: (context, string) =>
                                              const ShowProgress(),
                                          errorWidget: (context, string,
                                                  dynamic) =>
                                              const ShowImage(
                                                  path: 'images/image1.png'),
                                        ),
                                      ),
                                ShowText(
                                  label: cutWord(
                                      productModels[index].nameProduct, 10),
                                  textStyle: MyConstant().h2Style16(),
                                ),
                                ShowText(
                                    label: cutWord(
                                        productModels[index].detailProduct,
                                        25)),
                              ],
                            ),
                          ),
                        ),
                        itemCount: productModels.length,
                      ),
              ],
            ),
          ),
        );
      }),
    );
  }

  ListView showListProductPostOld() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: productModels.length,
      itemBuilder: (context, index) => Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    userModels[index].urlAvatar.isEmpty
                        ? ShowAvatarFollow(
                            imageProvider:
                                const AssetImage('images/avartar4.png'),
                            tapAvatarFunc: () {
                              print(
                                  'you tab avata name ไปโปรไฟร์ ==> ${userModels[index].name}');
                            },
                            pressAddFunc: () {
                              print(
                                  'you press add follow ${docDataCodes[index]}');
                            },
                          )
                        : ShowAvatarFollow(
                            imageProvider:
                                NetworkImage(userModels[index].urlAvatar),
                            tapAvatarFunc: () {
                              print(
                                  'you tab avata name ==> ${userModels[index].name}');
                            },
                            pressAddFunc: () {
                              print(
                                  'you press add follow ${docDataCodes[index]}');
                            },
                          ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: ShowText(
                  label: productModels[index].nameProduct,
                  textStyle: MyConstant().h2Style(),
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Row createAndRead(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ShowCardBox(
          label: 'สร้าง Link',
          pressFunc: () {
            if (checkLogin!) {
              Navigator.pushNamed(context, MyConstant.routeAddData);
            } else {
              requireLoginDialog();
            }
          },
          pathImage: 'images/image2.png',
        ),
        ShowCardBox(
          label: 'อ่าน QR code',
          pressFunc: () => processScanQRcode(),
          pathImage: 'images/image1.png',
        ),
      ],
    );
  }

  AppBar newAppBar() {
    return AppBar(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          // ignore: prefer_const_constructors
          SizedBox(
            width: 36,
            height: 36,
            child: const ShowImage(path: 'images/icon.png'),
          ),
        ],
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      title: ShowText(
        label: MyConstant.appName,
        textStyle: MyConstant().h2Style(),
      ),
      actions: [
        IconButton(
          onPressed: () {
            if (checkLogin!) {
              Navigator.pushNamedAndRemoveUntil(
                  context, MyConstant.routeAddData, (route) => false);
            } else {
              requireLoginDialog();
            }
          },
          icon: const Icon(Icons.add_box_outlined),
        ),
        load
            ? const SizedBox()
            : checkLogin!
                ? const ShowSignOut()
                : const SizedBox()
      ],
    );
  }

  Widget newWork(BoxConstraints constraints) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShowForm(
                    width: constraints.maxWidth * 0.5,
                    label: 'รหัสสินค้า',
                    changeFunc: (String string) => qrCode = string.trim(),
                  ),
                  SizedBox(
                    width: 56,
                    height: 48,
                    child: ShowButton(
                        textStyle: MyConstant().h3WhiteStyle(),
                        label: 'Go',
                        pressFunc: () async {
                          if (checkLogin!) {
                            if (qrCode?.isEmpty ?? true) {
                              MyDialog(context: context).normalDialog(
                                  'Have Space ?',
                                  'Please Fill Every Blank',
                                  'OK',
                                  () => Navigator.pop(context),
                                  'images/image2.png');
                            } else {
                              processCheckQR();
                            }
                          } else {
                            print('Login Require');
                            requireLoginDialog();
                          }
                        }),
                  ),
                  IconButton(
                    onPressed: () {
                      processScanQRcode();
                    },
                    icon: const Icon(
                      Icons.qr_code_scanner,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> processScanQRcode() async {
    try {
      var result = await scan();
      print('#10mar result QR code ==> $result');
      qrCode = result;
      processCheckQR();
    } catch (e) {}
  }

  void requireLoginDialog() {
    MyDialog(context: context).normalDialog(
      'ยังไม่ได้ Login',
      'กรุณา Login ก่อน คะ',
      'Login',
      () {
        Navigator.pop(context);
        Navigator.pushNamed(context, MyConstant.routeAuthen);
      },
      'images/image2.png',
    ).then((value) => processChcckLogin());
  }

  void processCheckQR() {
    bool result = false;
    ProductModel? model;
    for (var item in productModels) {
      if (qrCode == item.qrCode) {
        result = true;
        model = item;
      }
    }
    if (result) {
      print('#10mar found QRcode');
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowDetailQRcode(
              productModel: model,
            ),
          ));
    } else {
      MyDialog(context: context).normalDialog(
          'ไม่มี QRcode นี้',
          'ไม่มี $qrCode นี่ใน ฐานข้อมูล',
          'OK',
          () => Navigator.pop(context),
          'images/image3.png');
    }
  }

  String cutWord(String detailProduct, int word) {
    String string = detailProduct;
    if (string.length > word) {
      string = string.substring(0, word);
      string = '$string ...';
    }
    return string;
  }
}
