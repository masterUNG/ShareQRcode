import 'package:flutter/material.dart';
import 'package:shareqrcode/models/favorite_link_model.dart';
import 'package:shareqrcode/states/choose_or_create_sub_table.dart';
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

  TextEditingController nameController = TextEditingController();
  TextEditingController linkController = TextEditingController();

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
          layoutTable()
        ],
      ),
    );
  }

  LayoutBuilder layoutTable() {
    return LayoutBuilder(
          builder: (context, constraints) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: MyConstant().myBox(),
                width: constraints.maxWidth * 0.5 - 4,
                child: Column(
                  children: [
                    ShowText(
                      label: 'Table 1',
                      textStyle: MyConstant().h2Style(),
                    ),
                    favoritTable1Models.isEmpty
                        ? const SizedBox()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: favoritTable1Models.length,
                            itemBuilder: (context, index) => ShowText(
                              label: favoritTable1Models[index].nameItem,
                            ),
                          ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: MyConstant().myBox(),
                width: constraints.maxWidth * 0.5 - 4,
                child: Column(
                  children: [
                    ShowText(
                      label: 'Table 2',
                      textStyle: MyConstant().h2Style(),
                    ),
                    favoritTable2Models.isEmpty
                        ? const SizedBox()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: favoritTable2Models.length,
                            itemBuilder: (context, index) => ShowText(
                              label: favoritTable2Models[index].nameItem,
                            ),
                          ),
                  ],
                ),
              ),
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
          textEditingController: nameController,
        ),
        ShowForm(
          width: 150,
          label: 'Link : ',
          changeFunc: (String string) => link = string.trim(),
          textEditingController: linkController,
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
                    'กรุณาเลือกเก็บ ช่อง 1,2', 'Table1', 'Table2', () async {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChooseOrCreateSubTable(sourceTable: 'Table1',),
                      ));

                  // FavoriteLinkModel model =
                  //     FavoriteLinkModel(nameItem: name!, urlItem: link!);
                  // favoritTable1Models.add(model);
                  // nameController.text = '';
                  // linkController.text = '';
                  // Navigator.pop(context);
                  // setState(() {});
                }, () {
                  FavoriteLinkModel model =
                      FavoriteLinkModel(nameItem: name!, urlItem: link!);
                  favoritTable2Models.add(model);
                  nameController.text = '';
                  linkController.text = '';
                  Navigator.pop(context);
                  setState(() {});
                });
                setState(() {});
              }
            }),
      ],
    );
  }
}
