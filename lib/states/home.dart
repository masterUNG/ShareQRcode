// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart';
import 'package:shareqrcode/models/product_model.dart';
import 'package:shareqrcode/states/show_detail_qr_code.dart';
import 'package:shareqrcode/utility/my_constant.dart';
import 'package:shareqrcode/utility/my_dialog.dart';
import 'package:shareqrcode/widgets/show_card_box.dart';
import 'package:shareqrcode/widgets/show_form.dart';
import 'package:shareqrcode/widgets/show_image.dart';
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
        await FirebaseFirestore.instance
            .collection('dataCode')
            .doc(item.id)
            .collection('product')
            .get()
            .then((value) {
          for (var item in value.docs) {
            ProductModel productModel = ProductModel.fromMap(item.data());
            productModels.add(productModel);
            print('#10mar QR code ==> ${productModel.qrCode}');
          }
        });
      }
    });
  }

  Future<void> processChcckLogin() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event == null) {
        checkLogin = false;
      } else {
        checkLogin = true;
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
        return GestureDetector(onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
          behavior: HitTestBehavior.opaque,
          child: Column(
            children: [
              newWork(constraints),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ShowCardBox(
                    label: 'สร้าง QR code',
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
              )
            ],
          ),
        );
      }),
    );
  }

  AppBar newAppBar() {
    return AppBar(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 36,
            height: 36,
            child: ShowImage(path: 'images/icon.png'),
          ),
        ],
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      title: ShowText(
        label: 'ใส่ระหัสสินค้า หรือ สแกน',
        textStyle: MyConstant().h2Style(),
      ),
      actions: [
        load
            ? const SizedBox()
            : checkLogin!
                ? const ShowSignOut()
                : const SizedBox()
      ],
    );
  }

  Widget newWork(BoxConstraints constraints) {
    return Container(margin: EdgeInsets.symmetric(horizontal: 16),
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
                    width: constraints.maxWidth * 0.6,
                    label: 'รหัสสินค้า',
                    changeFunc: (String string) => qrCode = string.trim(),
                  ),
                  ShowButton(
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
}
