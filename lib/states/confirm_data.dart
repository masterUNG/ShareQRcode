// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:shareqrcode/models/product_model.dart';
import 'package:shareqrcode/utility/my_constant.dart';
import 'package:shareqrcode/utility/my_dialog.dart';
import 'package:shareqrcode/widgets/show_text.dart';
import 'package:shareqrcode/widgets/showbutton.dart';

class ConfirmData extends StatefulWidget {
  final ProductModel productModel;
  const ConfirmData({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  State<ConfirmData> createState() => _ConfirmDataState();
}

class _ConfirmDataState extends State<ConfirmData> {
  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showListImages(),
          ShowText(
            label: widget.productModel.nameProduct,
            textStyle: MyConstant().h2Style(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ShowText(
              label: widget.productModel.detailProduct,
              textStyle: MyConstant().h3Style(),
            ),
          ),
          ShowText(
            label: 'Link ที่สามารถติดต่อได้',
            textStyle: MyConstant().h2Style(),
          ),
          showListTitleLink(),
          newQRcode(),
          Container(
            margin: const EdgeInsets.only(top: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShowButton(
                    label: 'Confirm Product',
                    pressFunc: () => MyDialog(context: context).twoWayDialog(
                        title: 'Confirm Product',
                        message: 'Are You Sure ?',
                        saveOnlyFunc: () {
                          Navigator.pop(context);
                          processSaveData(post: false);
                        },
                        saveAndPostFunc: () {
                          processSaveData(post: true);
                          Navigator.pop(context);
                        })),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row newQRcode() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            RepaintBoundary(
              key: globalKey,
              child: SizedBox(
                width: 150,
                height: 150,
                child: QrImage(data: widget.productModel.qrCode),
              ),
            ),
            ShowText(label: widget.productModel.qrCode),
          ],
        ),
      ],
    );
  }

  Widget showListTitleLink() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: widget.productModel.titleItems.length,
          // physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShowText(label: widget.productModel.titleItems[index]),
              ShowText(
                label: widget.productModel.linkItems[index],
                textStyle: MyConstant().h3BlueStyle(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox showListImages() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.productModel.pathImages.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Image.network(widget.productModel.pathImages[index]),
        ),
      ),
    );
  }

  Future<void> processSaveData({required bool post}) async {
    Map<String, dynamic> map = widget.productModel.toMap();
    print('map ==> $map');
    map['post'] = post;

    var user = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance
        .collection('dataCode')
        .doc(user!.uid)
        .collection('product')
        .doc()
        .set(map)
        .then((value) => Navigator.pop(context));
  }
}
