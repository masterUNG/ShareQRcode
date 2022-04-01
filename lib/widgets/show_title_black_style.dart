// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shareqrcode/utility/my_constant.dart';
import 'package:shareqrcode/widgets/show_text.dart';

class ShowTitleBlackStyle extends StatelessWidget {
  final String title;
  const ShowTitleBlackStyle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          // width: 200,
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
