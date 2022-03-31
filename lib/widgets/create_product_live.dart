import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shareqrcode/models/favorite_link_model.dart';
import 'package:shareqrcode/states/display_create_product_online.dart';
import 'package:shareqrcode/utility/my_constant.dart';
import 'package:shareqrcode/utility/my_dialog.dart';
import 'package:shareqrcode/widgets/show_black_box.dart';
import 'package:shareqrcode/widgets/show_form.dart';
import 'package:shareqrcode/widgets/show_icon_button.dart';
import 'package:shareqrcode/widgets/show_menu_expansiontile.dart';
import 'package:shareqrcode/widgets/show_text.dart';
import 'package:shareqrcode/widgets/showbutton.dart';

class CreateProductLive extends StatefulWidget {
  const CreateProductLive({Key? key}) : super(key: key);

  @override
  State<CreateProductLive> createState() => _CreateProductLiveState();
}

class _CreateProductLiveState extends State<CreateProductLive> {
  var favoriteLinkModels = <FavoriteLinkModel>[];
  String? name, link, content, price, amount;
  File? file;

  Future<void> processTakePhoto(ImageSource imageSource) async {
    var result = await ImagePicker().pickImage(
      source: imageSource,
      maxWidth: 800,
      maxHeight: 800,
    );
    if (result != null) {
      file = File(result.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('สร้างสินค้า ออนไลด์'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
        behavior: HitTestBehavior.opaque,
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                file == null
                    ? const SizedBox()
                    : SizedBox(
                        width: 250,
                        height: 250,
                        child: Image.file(file!),
                      ),
                ShowBlackBox(
                  iconData: Icons.add_a_photo,
                  title: 'รูป',
                  pressFunc: () => processTakePhoto(ImageSource.camera),
                  iconButtonWidget: IconButton(
                    onPressed: () => processTakePhoto(ImageSource.gallery),
                    icon: const Icon(
                      Icons.add_photo_alternate,
                      color: Colors.white,
                    ),
                  ),
                ),
                ShowForm(
                  width: constraints.maxWidth,
                  label: 'ข้อความ',
                  changeFunc: (String string) => content = string.trim(),
                ),
                ShowForm(
                  width: constraints.maxWidth,
                  label: 'ราคา',
                  changeFunc: (String string) => price = string.trim(),
                ),
                ShowForm(
                  width: constraints.maxWidth,
                  label: 'จำนวน',
                  changeFunc: (String string) => amount = string.trim(),
                ),
                favoriteLinkModels.isEmpty
                    ? const SizedBox()
                    : Column(
                        children: [
                          newTitleContactLink('ลิ้งที่ใช้ติดต่อ'),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: favoriteLinkModels.length,
                            itemBuilder: (context, index) => Container(
                              margin: const EdgeInsets.only(
                                  bottom: 16, left: 16, right: 16),
                              decoration: MyConstant().blackBox(),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: ShowText(
                                        label:
                                            favoriteLinkModels[index].nameItem,
                                        textStyle: MyConstant().h2WhiteStyle(),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ShowText(
                                        label:
                                            favoriteLinkModels[index].urlItem,
                                        textStyle: MyConstant().h2PurpleStyle(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShowForm(
                        label: 'ชื่อ',
                        changeFunc: (String string) => name = string.trim(),
                        width: 140),
                    ShowForm(
                      label: 'ลิ้งค์ ที่มาติดต่อ',
                      changeFunc: (String string) => link = string.trim(),
                      width: 140,
                    ),
                    ShowIconButton(
                        iconData: Icons.add_circle,
                        pressFunc: () {
                          if ((name?.isEmpty ?? true) ||
                              (link?.isEmpty ?? true)) {
                            // MyDialog(context: context).normalDialog(
                            //     'Have Space',
                            //     'Please Fill All Blank',
                            //     'OK',
                            //     () => Navigator.pop(context),
                            //     'images/logo.png');
                          } else {
                            FavoriteLinkModel favoriteLinkModel =
                                FavoriteLinkModel(
                                    nameItem: name!, urlItem: link!);
                            favoriteLinkModels.add(favoriteLinkModel);
                            setState(() {});
                          }
                        },
                        tooltip: 'Add Link'),
                  ],
                ),
                // newTitleContactLink('โทรศัพย์ ที่ใช้ติดต่อ'),
                ShowBlackBox(
                  title: 'กดเพื่อสร้าง สินค้า',
                  pressFunc: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DisplayCreateProductOnline(
                            favoriteLinkModels: favoriteLinkModels,
                            content: content,
                            price: price,
                            amount: amount,
                            file: file,
                          ),
                        ));
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget newTitleContactLink(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 200,
          margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          decoration: MyConstant().blackBox(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShowText(
                  label: title,
                  textStyle: MyConstant().h2WhiteStyle(),
                ),
                // ShowText(
                //   label: favoriteLinkModels[index].urlItem,
                //   textStyle: MyConstant().h3BlueStyle(),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
