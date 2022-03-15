import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shareqrcode/models/user_model.dart';
import 'package:shareqrcode/utility/my_dialog.dart';
import 'package:shareqrcode/widgets/show_form.dart';
import 'package:shareqrcode/widgets/show_form_password.dart';
import 'package:shareqrcode/widgets/show_image.dart';
import 'package:shareqrcode/widgets/show_sizebox.dart';
import 'package:shareqrcode/widgets/showbutton.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? name, email, password, rePassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('สมัครสมาชิค'),
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: ShowImage(
                    path: 'images/image2.png',
                    width: constraints.maxWidth * 0.5,
                  ),
                ),
                ShowForm(
                    label: 'Name :',
                    changeFunc: (String string) => name = string.trim()),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: ShowForm(
                    label: 'Email :',
                    changeFunc: (String string) => email = string.trim(),
                  ),
                ),
                ShowFormPassword(
                  label: 'Password :',
                  changeFunc: (String string) => password = string.trim(),
                ),
                const ShowSizeBox(),
                ShowFormPassword(
                  label: 'Re Password :',
                  changeFunc: (String string) => rePassword = string.trim(),
                ),
                const ShowSizeBox(),
                ShowButton(
                    label: 'สมัครสมาชิค',
                    pressFunc: () {
                      if ((name?.isEmpty ?? true) ||
                          (email?.isEmpty ?? true) ||
                          (password?.isEmpty ?? true) ||
                          (rePassword?.isEmpty ?? true)) {
                        MyDialog(context: context).normalDialog(
                            'กรอกไม่ครบ',
                            'กรุณา กรอกให้ครบ',
                            'Ok',
                            () => Navigator.pop(context),
                            'images/image4.png');
                      } else if (password != rePassword) {
                        MyDialog(context: context).normalDialog(
                            'Password ไม่เหมือน RePassword',
                            'กรุณา กรอกให้ เหมือนกัน',
                            'Ok',
                            () => Navigator.pop(context),
                            'images/image2.png');
                      } else {
                        processCreateNewAccout();
                      }
                    }),
              ],
            ),
          ),
        );
      }),
    );
  }

  Future<void> processCreateNewAccout() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!)
        .then((value) async {
      UserModel userModel = UserModel(name: name!, urlAvatar: '');
      await FirebaseFirestore.instance
          .collection('dataCode')
          .doc(value.user!.uid)
          .set(userModel.toMap())
          .then((value) => Navigator.pop(context));
    }).catchError((onError) {
      MyDialog(context: context).normalDialog(onError.code, onError.message,
          'OK', () => Navigator.pop(context), 'images/image1.png');
    });
  }
}
