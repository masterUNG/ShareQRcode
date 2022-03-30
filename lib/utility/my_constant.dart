import 'package:flutter/material.dart';

class MyConstant {
  static String pathLine = 'https://line.me/en/';
  static String pathFacebook = 'https://www.facebook.com';
  static String pathWrChat = 'https://www.wechat.com';

  static String ungUid = '71YREC9GyJXsgo4foQi6dXi3vSC2';
  static String appName = 'Maneelive';

  static String routeHome = '/home';
  static String routeAddData = '/addData';
  static String routeCreateQRcode = '/createQRcode';
  static String routeWorkQRcode = '/workQRcode';
  static String routeShowList = '/showList';
  static String routeAuthen = '/authen';
  static String routeRegister = '/register';

  static Color primary = const Color(0xff7E57C2);
  static Color light = const Color(0xffb085f5);
  static Color dark = const Color(0xff4d2c91);

  static Color myBlack = Colors.black45;

  static List<String> noProfiles = [
    'images/avartar1.png',
    'images/avartar2.png',
    'images/avartar3.png',
    'images/avartar4.png',
    'images/avartar5.png',
    'images/avartar6.png',
  ];

  BoxDecoration myBox() => BoxDecoration(
      border: Border.all(color: MyConstant.dark),
      borderRadius: BorderRadius.circular(4));

  TextStyle h1Style() => const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      );

  TextStyle h2Style() => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
      );

  TextStyle h2WhiteStyle() => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      );

  TextStyle h2Style16() => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );

  TextStyle h3Style() => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );

  TextStyle h3BlueStyle() => const TextStyle(
        color: Colors.blue,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );

  TextStyle h3WhiteStyle() => const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      );
}
