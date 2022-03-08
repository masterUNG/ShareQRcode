// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shareqrcode/utility/my_constant.dart';
import 'package:shareqrcode/widgets/show_text.dart';

class AddData extends StatefulWidget {
  const AddData({
    Key? key,
  }) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  String? uidLogin;
  var itemDropdowns = <String>[];
  String? chooseItemDropdown;

  @override
  void initState() {
    super.initState();
    findUserData();
    itemDropdowns.add('+ Add New Item');
  }

  Future<void> findUserData() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      uidLogin = event!.uid;

      await FirebaseFirestore.instance
          .collection('dataCode')
          .doc(uidLogin)
          .get()
          .then((value) {
        print('value ==> ${value.data()}');
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
}
