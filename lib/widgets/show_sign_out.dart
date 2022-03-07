import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shareqrcode/utility/my_constant.dart';
import 'package:shareqrcode/utility/my_dialog.dart';

class ShowSignOut extends StatelessWidget {
  const ShowSignOut({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        MyDialog(context: context).normalDialog(
            'Sign Out ?', 'คุณต้องการ Sign Out ?', 'OK', () async {
          await FirebaseAuth.instance.signOut().then((value) {
            Navigator.pushNamedAndRemoveUntil(
                context, MyConstant.routeHome, (route) => false);
          });
        });
      },
      icon: const Icon(Icons.logout),
    );
  }
}
