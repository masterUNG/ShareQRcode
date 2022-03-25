// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shareqrcode/utility/my_constant.dart';
import 'package:shareqrcode/widgets/show_form.dart';
import 'package:shareqrcode/widgets/show_image.dart';
import 'package:shareqrcode/widgets/show_text.dart';
import 'package:shareqrcode/widgets/show_text_button.dart';

class MyDialog {
  final BuildContext context;
  MyDialog({
    required this.context,
  });

  Future<void> categoryAddDialog({
    required Function(String) changeFunc,
    required Function() addCatFunc,
  }) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: ListTile(
          leading: const SizedBox(
            width: 64,
            child: ShowImage(path: 'images/logo.png'),
          ),
          title: ShowText(
            label: 'Add New Category',
            textStyle: MyConstant().h2Style(),
          ),
        ),
        content: ShowForm(label: 'Name Category', changeFunc: changeFunc),
        actions: [
          ShowTextButton(
            label: 'Add Category',
            pressFunc: addCatFunc,
          ),
          ShowTextButton(
            label: 'Cancel',
            pressFunc: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Future<void> twoWayDialog({
    required String title,
    required String message,
    required Function() saveOnlyFunc,
    required Function() saveAndPostFunc,
  }) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: ListTile(
          leading: const SizedBox(
            width: 64,
            height: 64,
            child: ShowImage(path: 'images/image1.png'),
          ),
          title: ShowText(
            label: title,
            textStyle: MyConstant().h2Style(),
          ),
          subtitle: ShowText(label: message),
        ),
        actions: [
          TextButton(onPressed: saveOnlyFunc, child: const Text('Save Only')),
          TextButton(
              onPressed: saveAndPostFunc, child: const Text('Save and Post')),
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
        ],
      ),
    );
  }

  Future<void> chooseSourceDialog({
    required Function() cameraFunc,
    required Function() galleryFunc,
  }) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: ListTile(
          leading: const SizedBox(
            width: 64,
            child: ShowImage(path: 'images/camera.png'),
          ),
          title: ShowText(
            label: 'Please Choose Source Photo',
            textStyle: MyConstant().h2Style(),
          ),
          subtitle: const ShowText(label: 'Please tap Camera or Gallery'),
        ),
        actions: [
          TextButton(onPressed: cameraFunc, child: const Text('Camera')),
          TextButton(onPressed: galleryFunc, child: const Text('Gallery')),
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
        ],
      ),
    );
  }

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
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShowForm(label: 'ชื่อ Item', changeFunc: nameFunc),
            const SizedBox(
              height: 16,
            ),
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

  Future<void> discusDialog(
    String title,
    String message,
    String label1,
    String label2,
    Function() function1,
    Function() function2,
  ) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: const ShowImage(
            path: 'images/logo.png',
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
            onPressed: function1,
            child: Text(label1),
          ),
          TextButton(
            onPressed: function2,
            child: Text(label2),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}