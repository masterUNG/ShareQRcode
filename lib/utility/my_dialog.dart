// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shareqrcode/utility/my_constant.dart';
import 'package:shareqrcode/widgets/show_image.dart';
import 'package:shareqrcode/widgets/show_text.dart';

class MyDialog {
  final BuildContext context;
  MyDialog({
    required this.context,
  });

  void addNewItemDialog() {}

  Future<void> normalDialog(
    String title,
    String message,
    String label,
    Function() function,
    String pathImage,
  ) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(path: pathImage, width: 64,),
          title: ShowText(
            label: title,
            textStyle: MyConstant().h2Style(),
          ),
        ),
        content: ShowText(label: message),
        actions: [
          TextButton(
            onPressed: function,
            child: Text(label),
          ),
        ],
      ),
    );
  }
}
