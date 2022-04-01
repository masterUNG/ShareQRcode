// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:shareqrcode/models/favorite_link_model.dart';
import 'package:shareqrcode/utility/my_constant.dart';
import 'package:shareqrcode/widgets/show_black_box.dart';
import 'package:shareqrcode/widgets/show_form.dart';
import 'package:shareqrcode/widgets/show_image.dart';
import 'package:shareqrcode/widgets/show_text.dart';
import 'package:shareqrcode/widgets/show_title_black_style.dart';
import 'package:shareqrcode/widgets/showbutton.dart';

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
  var favoriteLinkModels = <FavoriteLinkModel>[];

  GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    file = widget.file;
    content = widget.content;
    price = widget.price;
    amount = widget.amount;
    if (widget.favoriteLinkModels != null) {
      favoriteLinkModels = widget.favoriteLinkModels!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Display Product Online'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
        behavior: HitTestBehavior.opaque,
        child: ListView(
          children: [
            const SizedBox(
              height: 36,
            ),
            newImage(),
            const SizedBox(
              height: 36,
            ),
            newTitle(head: 'รายละเอียด', title: content ?? '?'),
            newTitle(head: 'ราคา', title: price ?? '?'),
            newTitle(head: 'คงเหลือ', title: amount ?? '?'),
            ShowForm(
                label: 'ต้องการซื้อสินค่า .... ชิ้น',
                changeFunc: (String string) {}),
            ShowBlackBox(title: 'กดสั่งซื้อ', pressFunc: () {}),
            newTitle(head: 'ช่องทางการติดต่อ', title: ''),
            favoriteLinkModels.isEmpty
                ? Text('no data')
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: favoriteLinkModels.length,
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      decoration: MyConstant().blackBox(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ShowText(
                              label: favoriteLinkModels[index].nameItem,
                              textStyle: MyConstant().h2WhiteStyle(),
                            ),
                            ShowText(
                              label: favoriteLinkModels[index].urlItem,
                              textStyle: MyConstant().h3BlueStyle(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            newTitle(head: 'รีวิวสินค้า', title: ''),
            neweQRgenCode(),
            ShowBlackBox(iconLeading: const Icon(Icons.rectangle, color: Colors.blue,),
              title: 'Copy Link สินค้า',
              pressFunc: () {},
            ),
            ShowBlackBox(iconLeading: const Icon(Icons.rectangle, color: Colors.green,),
              title: 'แชร์ลิ้ง',
              pressFunc: () {},
            ),
            ShowBlackBox(iconLeading: const Icon(Icons.rectangle, color: Colors.purple,),
              title: 'แชร์ QR code',
              pressFunc: () {},
            ),
            ShowBlackBox(iconLeading: const Icon(Icons.rectangle, color: Colors.orange,),
              title: 'เก็บไว้ในสินค้าถูกใจ',
              pressFunc: () {},
            ),
           ShowButton(label: 'Save', pressFunc: (){}),
          ],
        ),
      ),
    );
  }

  Widget neweQRgenCode() {
    String code = processGenCode();
    return RepaintBoundary(
      key: globalKey,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: QrImage(data: code),
          ),
          ShowText(
            label: code,
            textStyle: MyConstant().h2Style(),
          )
        ],
      ),
    );
  }

  Widget newTitle({required String head, required String title}) =>
      ShowTitleBlackStyle(title: '$head :  $title');

  Widget newImage() => file == null
      ? const SizedBox(
          width: 250,
          child: ShowImage(),
        )
      : SizedBox(
          width: 250,
          child: Image.file(file!),
        );

  String processGenCode() {
    String code = 'code${Random().nextInt(100000)}';
    return code;
  }
}
