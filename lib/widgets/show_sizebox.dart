import 'package:flutter/material.dart';

class ShowSizeBox extends StatelessWidget {
  final double? hight;
  const ShowSizeBox({
    Key? key,
    this.hight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: hight ?? 16,
      width: 16,
    );
  }
}
