// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shareqrcode/utility/my_constant.dart';
import 'package:shareqrcode/widgets/show_text.dart';

class ShowFormPassword extends StatefulWidget {
  final String label;
  final Function(String) changeFunc;
  final double? width;
  const ShowFormPassword({
    Key? key,
    required this.label,
    required this.changeFunc,
    this.width,
  }) : super(key: key);

  @override
  State<ShowFormPassword> createState() => _ShowFormPasswordState();
}

class _ShowFormPasswordState extends State<ShowFormPassword> {
  bool obsecu = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: widget.width ?? 200,
      height: 40,
      child: TextFormField(
        obscureText: obsecu,
        onChanged: widget.changeFunc,
        decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obsecu = !obsecu;
                });
              },
              icon: const Icon(Icons.remove_red_eye_outlined)),
          label: ShowText(label: widget.label),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyConstant.dark)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyConstant.light)),
        ),
      ),
    );
  }
}
