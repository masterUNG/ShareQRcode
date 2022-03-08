// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shareqrcode/utility/my_constant.dart';
import 'package:shareqrcode/widgets/show_form.dart';
import 'package:shareqrcode/widgets/show_image.dart';
import 'package:shareqrcode/widgets/show_text.dart';

class MyDialog {
  final BuildContext context;
  MyDialog({
    required this.context,
  });

  Future<void> addNewItemDialog({
    required String title,
    required String message,
    required String labelButton,
    required Function() function,
    required Function(String) nameFunc,
    required Function(String) urlFunc,
    String? pathImage,
  }) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: ListTile(
          leading: SizedBox(
            width: 64,
            height: 64,
            child: ShowImage(path: pathImage ?? 'images/image1.png'),
          ),
          title: ShowText(
            label: title,
            textStyle: MyConstant().h2Style(),
          ),
          subtitle: ShowText(label: message),
        ),
        content: Column(mainAxisSize: MainAxisSize.min,
          children: [
            ShowForm(label: 'ชื่อ Item', changeFunc: nameFunc),
            const SizedBox(height: 16,),
            ShowForm(label: 'Link Url', changeFunc: urlFunc),
          ],
        ),
        actions: [
          TextButton(onPressed: function, child: Text(labelButton)),
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
        ],
      ),
    );
  }

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
          leading: ShowImage(
            path: pathImage,
            width: 64,
          ),
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
