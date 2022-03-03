import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shareqrcode/utility/my_constant.dart';
import 'package:shareqrcode/utility/my_dialog.dart';
import 'package:shareqrcode/widgets/show_text.dart';
import 'package:shareqrcode/widgets/showbutton.dart';

class CreateQRcode extends StatefulWidget {
  const CreateQRcode({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateQRcode> createState() => _CreateQRcodeState();
}

class _CreateQRcodeState extends State<CreateQRcode> {
  String? chooseLink, randomCode;
  GlobalKey globalKey = GlobalKey();
  bool display = false;

  var itemLinks = <String>[];

  @override
  void initState() {
    super.initState();
    itemLinks.add(MyConstant.pathLine);
    itemLinks.add(MyConstant.pathFacebook);
    itemLinks.add(MyConstant.pathWrChat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('การสร้างรหัส'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<dynamic>(
                hint: newTitle(),
                value: chooseLink,
                items: itemLinks
                    .map(
                      (e) => DropdownMenuItem(
                        child: ShowText(label: e),
                        value: e,
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    chooseLink = value.toString();
                  });
                }),
            createQRcodeButton(),
            showQR(),
          ],
        ),
      ),
    );
  }

  ShowText newTitle() {
    return ShowText(
      label: 'เลือก Link',
      textStyle: MyConstant().h2Style(),
    );
  }

  Widget showQR() {
    return display
        ? Center(
          child: Column(
              children: [
               
                SizedBox(width: 250,height: 250,
                  child: QrImage(data: randomCode!),
                ),
                 ShowText(label: 'code ==> $randomCode'),
              ],
            ),
        )
        : const SizedBox();
  }

  Row createQRcodeButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowButton(
            label: 'Create QR code',
            pressFunc: () {
              if (chooseLink == null) {
                MyDialog(context: context).normalDialog('ยังไม่ได้เลือก Link',
                    'กรุณาเลือก Link', 'OK', () => Navigator.pop(context));
              } else {
                processGenQRcode();
              }
            }),
      ],
    );
  }

  RadioListTile<String> radioLine() {
    return RadioListTile(
        title: ShowText(
          label: 'Line',
          textStyle: MyConstant().h3Style(),
        ),
        value: MyConstant.pathLine,
        groupValue: chooseLink,
        onChanged: (value) {
          setState(() {
            chooseLink = value;
          });
        });
  }

  RadioListTile<String> radioFacebook() {
    return RadioListTile(
        title: ShowText(
          label: 'Facebook',
          textStyle: MyConstant().h3Style(),
        ),
        value: MyConstant.pathFacebook,
        groupValue: chooseLink,
        onChanged: (value) {
          setState(() {
            chooseLink = value;
          });
        });
  }

  RadioListTile<String> radioWeChart() {
    return RadioListTile(
        title: ShowText(
          label: 'WeChat',
          textStyle: MyConstant().h3Style(),
        ),
        value: MyConstant.pathWrChat,
        groupValue: chooseLink,
        onChanged: (value) {
          setState(() {
            chooseLink = value;
          });
        });
  }

  Future<void> processGenQRcode() async {
    randomCode = 'code${Random().nextInt(10000)}';

    setState(() {
      display = true;
    });
  }
}
