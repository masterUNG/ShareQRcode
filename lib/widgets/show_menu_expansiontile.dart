// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shareqrcode/utility/my_constant.dart';

import 'package:shareqrcode/widgets/show_text.dart';

class ShowMenuExpansionTile extends StatelessWidget {
  final String title;
  final List<Widget> widgets;
  const ShowMenuExpansionTile({
    Key? key,
    required this.title,
    required this.widgets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.black45, borderRadius: BorderRadius.circular(30)),
      child: ExpansionTile(
        trailing: const Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        title: ShowText(
          label: title,
          textStyle: MyConstant().h2WhiteStyle(),
        ),
        children: widgets,
      ),
    );
  }
}
