import 'package:flutter/material.dart';
import 'package:shareqrcode/widgets/show_form.dart';
import 'package:shareqrcode/widgets/show_text.dart';

class InputData extends StatefulWidget {
  const InputData({Key? key}) : super(key: key);

  @override
  State<InputData> createState() => _InputDataState();
}

class _InputDataState extends State<InputData> {
  String? permission;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ShowForm(label: 'ชื่อลิ้ง', changeFunc: (String string) {}),
            RadioListTile(
              value: 'private',
              groupValue: permission,
              onChanged: (value) {
                setState(() {
                  permission = value.toString();
                });
              },
              title: const ShowText(label: 'Private'),
            ),
            RadioListTile(
              value: 'publish',
              groupValue: permission,
              onChanged: (value) {
                  setState(() {
                  permission = value.toString();
                });
              },
              title: const ShowText(label: 'Publish'),
            ),
            ShowForm(label: 'UrlLink', changeFunc: (String string){}),
          ],
        ),
      ),
    );
  }
}
