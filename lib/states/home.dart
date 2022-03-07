// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shareqrcode/states/create_qr_code.dart';
import 'package:shareqrcode/states/work_qr_code.dart';
import 'package:shareqrcode/utility/my_constant.dart';
import 'package:shareqrcode/utility/my_dialog.dart';
import 'package:shareqrcode/widgets/show_form.dart';
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

  @override
  void initState() {
    super.initState();
    processChcckLogin();
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
      appBar: AppBar(
        actions: [
          load
              ? const SizedBox()
              : checkLogin!
                  ? const ShowSignOut()
                  : const SizedBox()
        ],
      ),
      body: Column(
        children: [
          newWork(),
          ShowButton(
            label: 'สร้าง ระหัสสินค้า และ อื่นๆ',
            pressFunc: () =>
                Navigator.pushNamed(context, MyConstant.routeAddData),
          )
        ],
      ),
    );
  }

  Card newWork() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShowText(
              label: 'การใส่ระหัสสินค้า หรือ สแกน',
              textStyle: MyConstant().h2Style(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShowForm(
                  label: 'รหัสสินค้า',
                  changeFunc: (String string) {},
                ),
                ShowButton(
                    label: 'Go',
                    pressFunc: () async {
                      if (checkLogin!) {
                        print('Login OK');
                      } else {
                        print('Login Require');
                        MyDialog(context: context).normalDialog(
                            'ยังไม่ได้ Login', 'กรุณา Login ก่อน คะ', 'Login',
                            () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, MyConstant.routeAuthen);
                        }).then((value) => processChcckLogin());
                      }
                    }),
                ShowButton(label: 'QR code', pressFunc: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
