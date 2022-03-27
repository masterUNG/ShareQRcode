// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shareqrcode/utility/my_constant.dart';
import 'package:shareqrcode/widgets/show_text.dart';

class ShowForm extends StatelessWidget {
  final String label;
  final Function(String) changeFunc;
  final bool? obsecu;
  final double? width;
  final TextEditingController? textEditingController;
  const ShowForm({
    Key? key,
    required this.label,
    required this.changeFunc,
    this.obsecu,
    this.width,
    this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: width ?? 200,
      height: 40,
      child: TextFormField(controller: textEditingController,
        obscureText: obsecu ?? false,
        onChanged: changeFunc,
        decoration: InputDecoration(
          label: ShowText(label: label),
          enabledBorder:  OutlineInputBorder(borderSide: BorderSide(color: MyConstant.dark)),
          focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: MyConstant.light)),
        ),
      ),
    );
  }
}
