// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shareqrcode/utility/my_constant.dart';

class ShowButton extends StatelessWidget {
  final String label;
  final Function() pressFunc;
  final TextStyle? textStyle;
  final Color? color;
  const ShowButton({
    Key? key,
    required this.label,
    required this.pressFunc,
    this.textStyle,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: color ?? MyConstant.primary),
        onPressed: pressFunc,
        child: Text(
          label,
          style: textStyle,
        ),
      ),
    );
  }
}
