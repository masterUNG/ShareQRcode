import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shareqrcode/widgets/show_image.dart';
import 'package:shareqrcode/widgets/showbutton.dart';

class ShowImageFromGallery extends StatefulWidget {
  const ShowImageFromGallery({Key? key}) : super(key: key);

  @override
  State<ShowImageFromGallery> createState() => _ShowImageFromGalleryState();
}

class _ShowImageFromGalleryState extends State<ShowImageFromGallery> {
  File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show Image From Gallery'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: file == null ? const ShowImage(
                path: 'images/camera.png',
              ) : Image.file(file!),
            ),
            ShowButton(
                label: 'Gallery',
                pressFunc: () async {
                  var result = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                      maxWidth: 800,
                      maxHeight: 800);
                  setState(() {
                    file = File(result!.path);
                  });
                }),
          ],
        ),
      ),
    );
  }
}
