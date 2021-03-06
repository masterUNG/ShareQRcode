import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shareqrcode/utility/my_constant.dart';
import 'package:shareqrcode/utility/my_dialog.dart';
import 'package:shareqrcode/widgets/show_form.dart';
import 'package:shareqrcode/widgets/show_form_password.dart';
import 'package:shareqrcode/widgets/show_image.dart';
import 'package:shareqrcode/widgets/show_sizebox.dart';
import 'package:shareqrcode/widgets/showbutton.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: const Text('Login'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const ShowImage(
                  path: 'images/image1.png',
                ),
                ShowForm(
                  label: 'Email :',
                  changeFunc: (String string) => email = string.trim(),
                ),
                const ShowSizeBox(),
                ShowFormPassword(
                  label: 'Password :',
                  changeFunc: (String string) => password = string.trim(),
                 
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShowButton(
                        label: 'Login',
                        pressFunc: () {
                          if ((email?.isEmpty ?? true) ||
                              (password?.isEmpty ?? true)) {
                            MyDialog(context: context).normalDialog(
                              '?????????????????????????????? ?',
                              '???????????????????????????????????????????????? ??????',
                              'OK',
                              () => Navigator.pop(context),
                              'images/image4.png',
                            );
                          } else {
                            processCheckAuthen();
                          }
                        }),
                        ShowButton(label: 'Register', pressFunc: ()=> Navigator.pushNamed(context, MyConstant.routeRegister)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> processCheckAuthen() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!)
        .then((value) => Navigator.pop(context))
        .catchError((onError) {
      MyDialog(context: context).normalDialog(
        onError.code,
        onError.message,
        'OK',
        () => Navigator.pop(context),
        'images/image3.png',
      );
    });
  }
}
