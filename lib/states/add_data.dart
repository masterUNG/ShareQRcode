import 'package:cloud_firestore/cloud_firestore.dart';
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
  String uidLogin = MyConstant.ungUid;
  var itemDropdowns = <String>['+ Add New Item'];
  String? chooseItemDropdown;

  @override
  void initState() {
    super.initState();
    findUserData();
  }

  Future<void> findUserData() async {
    await FirebaseFirestore.instance
        .collection('dataCode')
        .doc(uidLogin)
        .get()
        .then((value) {
      print('value ==> ${value.data()}');
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
                onChanged: (value) {})
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
