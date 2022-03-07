import 'package:flutter/material.dart';

class MyConstant {
  static String pathLine = 'https://line.me/en/';
  static String pathFacebook = 'https://www.facebook.com';
  static String pathWrChat = 'https://www.wechat.com';

  static String ungUid = '71YREC9GyJXsgo4foQi6dXi3vSC2';

  static String routeHome = '/home';
  static String routeAddData = '/addData';
  static String routeCreateQRcode = '/createQRcode';
  static String routeWorkQRcode = '/workQRcode';
  static String routeShowList = '/showList';
  static String routeAuthen = '/authen';

  TextStyle h1Style() => const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      );

  TextStyle h2Style() => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
      );

  TextStyle h3Style() => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );
}
