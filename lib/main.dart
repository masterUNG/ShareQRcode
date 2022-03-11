import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shareqrcode/listtileWidget.dart';
import 'package:shareqrcode/states/add_data.dart';
import 'package:shareqrcode/states/authen.dart';
import 'package:shareqrcode/states/create_qr_code.dart';
import 'package:shareqrcode/states/home.dart';
import 'package:shareqrcode/states/register.dart';
import 'package:shareqrcode/states/show_list.dart';
import 'package:shareqrcode/states/work_qr_code.dart';
import 'package:shareqrcode/utility/my_constant.dart';

final Map<String, WidgetBuilder> map = {
  MyConstant.routeAddData: (context) => const AddData(),
  MyConstant.routeCreateQRcode: (context) => const CreateQRcode(),
  MyConstant.routeHome: (context) => const Home(),
  MyConstant.routeShowList: (context) => const ShowList(),
  MyConstant.routeWorkQRcode: (context) => const WorkQRcode(),
  MyConstant.routeAuthen: (context) => const Authen(),
  MyConstant.routeRegister: (context) => const Register(),
};

String? initial;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    initial = MyConstant.routeHome;
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      routes: map,
      initialRoute: initial,
    );
  }
}
