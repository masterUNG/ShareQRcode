// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:shareqrcode/models/favorite_link_model.dart';
import 'package:shareqrcode/widgets/show_image.dart';
import 'package:shareqrcode/widgets/show_text.dart';

class DisplayCreateProductOnline extends StatefulWidget {
  final File? file;
  final String? content;
  final String? price;
  final String? amount;
  final List<FavoriteLinkModel>? favoriteLinkModels;
  const DisplayCreateProductOnline({
    Key? key,
    this.file,
    this.content,
    this.price,
    this.amount,
    this.favoriteLinkModels,
  }) : super(key: key);

  @override
  State<DisplayCreateProductOnline> createState() =>
      _DisplayCreateProductOnlineState();
}

class _DisplayCreateProductOnlineState
    extends State<DisplayCreateProductOnline> {
  File? file;
  String? content, price, amount;

  @override
  void initState() {
    super.initState();
    file = widget.file;
    content = widget.content;
    price = widget.price;
    amount = widget.amount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Display Product Online'),
      ),
      body: Column(
        children: [
          newImage(),
          ShowText(label: content ?? 'not thing')
        ],
      ),
    );
  }

  Widget newImage() => file == null
      ? const SizedBox(
          width: 250,
          child: ShowImage(),
        )
      : SizedBox(
          width: 250,
          child: Image.file(file!),
        );
}
