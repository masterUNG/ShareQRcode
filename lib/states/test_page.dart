import 'package:flutter/material.dart';
import 'package:shareqrcode/models/favorite_link_model.dart';
import 'package:shareqrcode/utility/my_constant.dart';
import 'package:shareqrcode/utility/my_dialog.dart';
import 'package:shareqrcode/widgets/show_form.dart';
import 'package:shareqrcode/widgets/show_text.dart';
import 'package:shareqrcode/widgets/showbutton.dart';

class TestPage extends StatefulWidget {
  const TestPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String? name, link;
  var favoritTable1Models = <FavoriteLinkModel>[];
  var favoritTable2Models = <FavoriteLinkModel>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 36,
          ),
          newForm(),
          const SizedBox(
            height: 36,
          ),
          LayoutBuilder(
            builder: (context, constraints) => Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: constraints.maxWidth * 0.5,
                      child: ShowText(
                        label: 'Table 1',
                        textStyle: MyConstant().h2Style(),
                      ),
                    ),
                    favoritTable1Models.isEmpty
                        ? const SizedBox()
                        : Text('list table1'),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      width: constraints.maxWidth * 0.5,
                      child: ShowText(
                        label: 'Table 2',
                        textStyle: MyConstant().h2Style(),
                      ),
                    ),
                    favoritTable1Models.isEmpty
                        ? const SizedBox()
                        : Text('list table1'),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Row newForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ShowForm(
          width: 150,
          label: 'Name : ',
          changeFunc: (String string) => name = string.trim(),
        ),
        ShowForm(
          width: 150,
          label: 'Link : ',
          changeFunc: (String string) => link = string.trim(),
        ),
        ShowButton(
            label: 'OK',
            pressFunc: () {
              if ((name?.isEmpty ?? true) || (link?.isEmpty ?? true)) {
                MyDialog(context: context).normalDialog(
                    'Have Space',
                    'Please Fill Data',
                    'OK',
                    () => Navigator.pop(context),
                    'images/logo.png');
              } else {
                MyDialog(context: context).discusDialog('เลือกเก็บข้อมูล',
                    'กรุณาเลือกเก็บ ช่อง 1,2', 'Table1', 'Table2', () {
                  FavoriteLinkModel model =
                      FavoriteLinkModel(nameItem: name!, urlItem: link!);
                  favoritTable1Models.add(model);
                }, () {
                  FavoriteLinkModel model =
                      FavoriteLinkModel(nameItem: name!, urlItem: link!);
                  favoritTable2Models.add(model);
                });
                setState(() {});
              }
            }),
      ],
    );
  }
}
