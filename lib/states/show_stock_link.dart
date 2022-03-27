import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shareqrcode/models/favorite_link_model.dart';
import 'package:shareqrcode/utility/my_constant.dart';
import 'package:shareqrcode/utility/my_dialog.dart';
import 'package:shareqrcode/widgets/show_icon_button.dart';
import 'package:shareqrcode/widgets/show_progress.dart';
import 'package:shareqrcode/widgets/show_text.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowStockLink extends StatefulWidget {
  const ShowStockLink({
    Key? key,
  }) : super(key: key);

  @override
  State<ShowStockLink> createState() => _ShowStockLinkState();
}

class _ShowStockLinkState extends State<ShowStockLink> {
  bool load = true;
  bool? haveData;
  var favoriteLinkModels = <FavoriteLinkModel>[];
  var docIdFavoriteLinks = <String>[];
  var checkLists = <bool>[];

  var user = FirebaseAuth.instance.currentUser;

  bool checkListAll = false;

  @override
  void initState() {
    super.initState();
    readFavoricLink();
  }

  Future<void> readFavoricLink() async {
    if (favoriteLinkModels.isNotEmpty) {
      favoriteLinkModels.clear();
      docIdFavoriteLinks.clear();
    } else {}

    await FirebaseFirestore.instance
        .collection('dataCode')
        .doc(user!.uid)
        .collection('favoritlink')
        .orderBy('nameItem')
        .get()
        .then((value) {
      load = false;
      if (value.docs.isEmpty) {
        haveData = false;
      } else {
        haveData = true;
        for (var item in value.docs) {
          FavoriteLinkModel favoriteLinkModel =
              FavoriteLinkModel.fromMap(item.data());
          favoriteLinkModels.add(favoriteLinkModel);
          docIdFavoriteLinks.add(item.id);
          checkLists.add(false);
        }
      }
      setState(() {});
    });
  }

  Center newNoData() {
    return Center(
        child: ShowText(
      label: 'No Stock Link',
      textStyle: MyConstant().h1Style(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show Stock Link'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          ShowIconButton(
            iconData: Icons.queue,
            pressFunc: () => processAddGroup(),
            tooltip: 'Add Group',
          )
        ],
      ),
      body: load
          ? const ShowProgress()
          : haveData!
              ? SingleChildScrollView(
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Column(
                      children: [
                        Container(
                          decoration:
                              BoxDecoration(color: Colors.grey.shade300),
                          child: Row(
                            children: [
                              SizedBox(
                                width: constraints.maxWidth * 0.5,
                                child: CheckboxListTile(
                                  value: checkListAll,
                                  onChanged: (value) {
                                    setState(() {
                                      checkListAll = value!;
                                      for (var i = 0;
                                          i < checkLists.length;
                                          i++) {
                                        checkLists[i] = value;
                                      }
                                    });
                                  },
                                  title: const ShowText(label: 'Name Title'),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.5,
                                child: ShowText(
                                  label: 'Url Link',
                                  textStyle: MyConstant().h3BlueStyle(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        newListStockLink(constraints),
                      ],
                    );
                  }),
                )
              : newNoData(),
    );
  }

  Widget newListStockLink(BoxConstraints constraints) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: favoriteLinkModels.length,
      itemBuilder: (context, index) => Card(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: constraints.maxWidth * 0.5 - 8,
                  child: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    value: checkLists[index],
                    onChanged: (value) {
                      setState(() {
                        checkLists[index] = value!;
                      });
                    },
                    title: ShowText(
                        label:
                            '${index + 1}. ${favoriteLinkModels[index].nameItem}'),
                  ),
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.5 - 8,
                  child: ShowText(
                    label: favoriteLinkModels[index].urlItem,
                    textStyle: MyConstant().h3BlueStyle(),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ShowIconButton(
                  iconData: Icons.play_arrow_outlined,
                  pressFunc: () => processPlayLink(favoriteLinkModels[index]),
                  tooltip: 'แสดงลิ้งค์',
                ),
                ShowIconButton(
                  iconData: Icons.delete_outline,
                  pressFunc: () {
                    MyDialog(context: context).confirmActionDialog(
                        title: 'Confirm Delete ?',
                        actionFunc: () {
                          processDeleteLink(docIdFavoriteLinks[index]);
                          Navigator.pop(context);
                        });
                  },
                  tooltip: 'ลบลิ้งค์',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> processDeleteLink(String docIdFavoriteLink) async {
    print('delete at ==>> $docIdFavoriteLink');
    await FirebaseFirestore.instance
        .collection('dataCode')
        .doc(user!.uid)
        .collection('favoritlink')
        .doc(docIdFavoriteLink)
        .delete()
        .then((value) => readFavoricLink());
  }

  Future<void> processPlayLink(FavoriteLinkModel favoriteLinkModel) async {
    if (await canLaunch(favoriteLinkModel.urlItem)) {
      await launch(favoriteLinkModel.urlItem);
    } else {
      MyDialog(context: context).normalDialog(
          'Link False ?',
          'ลิ้งที่ได้มา ไม่สามารถทำงานได้ คะ',
          'OK',
          () => Navigator.pop(context),
          'images/logo.png');
    }
  }

  Future<void> processAddGroup() async {
    bool checkChooseLink = false; // false ==> ยังไม่ได้เลือก ลิ้งเลย

    for (var item in checkLists) {
      if (item) {
        checkChooseLink = true;
      }
    }

    if (checkChooseLink) {
      print('มีการ เลือกแล้ว');

      var docIdFavorityChooses = <String>[];
      var favoritLinkModelsChooses = <FavoriteLinkModel>[];

      int i = 0;
      for (var item in checkLists) {
        if (item) {
          docIdFavorityChooses.add(docIdFavoriteLinks[i]);
          favoritLinkModelsChooses.add(favoriteLinkModels[i]);
        }
        i++;
      }

      print('#26mar docIdFavorityChooses ==>> $docIdFavorityChooses');

      String? nameGroup;

      MyDialog(context: context).addGroupLinkDialog(
        changeFunc: (String string) => nameGroup = string.trim(),
        favolitLinkModels: favoritLinkModelsChooses,
        addFunc: () {
          Navigator.pop(context);
          if (nameGroup?.isEmpty ?? true) {
            MyDialog(context: context).normalDialog(
                'No Name Group',
                'Please Fill Name Group',
                'OK',
                () => Navigator.pop(context),
                'images/logo.png');
          } else {}
        },
      );
    } else {
      MyDialog(context: context).normalDialog(
          'ยังไม่เลือกลิ้งค์',
          'กรุณาเลือก ลิ้งค์ ด้วยคะ',
          'OK',
          () => Navigator.pop(context),
          'images/logo.png');
    }
  }
}
