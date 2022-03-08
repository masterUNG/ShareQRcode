// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shareqrcode/models/favorite_link_model.dart';
import 'package:shareqrcode/utility/my_constant.dart';
import 'package:shareqrcode/utility/my_dialog.dart';
import 'package:shareqrcode/widgets/show_text.dart';

class AddData extends StatefulWidget {
  const AddData({
    Key? key,
  }) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  String? uidLogin, nameItem, urlItem;
  var itemDropdowns = <String>[];
  String? chooseItemDropdown;

  @override
  void initState() {
    super.initState();
    findUserData();
  }

  Future<void> findUserData() async {
    if (itemDropdowns.isNotEmpty) {
  itemDropdowns.clear();
}

    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      uidLogin = event!.uid;

      await FirebaseFirestore.instance
          .collection('dataCode')
          .doc(uidLogin)
          .collection('favoritlink')
          .get()
          .then((value) {
        for (var item in value.docs) {
          FavoriteLinkModel favoriteLinkModel =
              FavoriteLinkModel.fromMap(item.data());
          itemDropdowns.add(favoriteLinkModel.nameItem);
        }

        itemDropdowns.add('+ Add New Item');

        setState(() {});

        // print('##8March value ==> ${value.docs}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Data'),
      ),
      body: Center(
        child: Column(
          children: [
            newTitle(),
            DropdownButton<dynamic>(
                hint: const ShowText(label: 'Please Choose Item'),
                value: chooseItemDropdown,
                items: itemDropdowns
                    .map(
                      (e) => DropdownMenuItem(
                        child: ShowText(label: e),
                        value: e,
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  String string = value;
                  print('string = $string');
                  if (value == itemDropdowns[itemDropdowns.length - 1]) {
                    print('Choose Add item');
                    MyDialog(context: context).addNewItemDialog(
                      title: 'เพิ่ม Item',
                      message: 'กรุณากรอก ข้อมูลให้ครบทุกช่อง คะ',
                      labelButton: 'Add Item',
                      pathImage: 'images/image3.png',
                      function: () {
                        Navigator.pop(context);
                        if ((nameItem?.isEmpty ?? true) ||
                            (urlItem?.isEmpty ?? true)) {
                          MyDialog(context: context).normalDialog(
                              'มีช่องว่าง ?',
                              'กรุณากรอก ให้ครบทุกช่อง คะ',
                              'OK',
                              () => Navigator.pop(context),
                              'images/image2.png');
                        } else {
                          processAddNewItem();
                        }
                      },
                      nameFunc: (String name) => nameItem = name.trim(),
                      urlFunc: (String url) => urlItem = url.trim(),
                    );
                  } else {
                    print('not choose Add item');
                  }
                })
          ],
        ),
      ),
    );
  }

  ShowText newTitle() {
    return ShowText(
      label: 'เพิ่มข้อมูล',
      textStyle: MyConstant().h2Style(),
    );
  }

  Future<void> processAddNewItem() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      String uidLogin = event!.uid;
      print('nameItem ==> $nameItem, urlItem = $urlItem, uidLogin = $uidLogin');

      FavoriteLinkModel favoriteLinkModel =
          FavoriteLinkModel(nameItem: nameItem!, urlItem: urlItem!);

      await FirebaseFirestore.instance
          .collection('dataCode')
          .doc(uidLogin)
          .collection('favoritlink')
          .doc()
          .set(favoriteLinkModel.toMap())
          .then((value) {
        print('Success add Item');
        findUserData();
      });
    });
  }
}
