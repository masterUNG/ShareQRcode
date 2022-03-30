import 'package:flutter/material.dart';
import 'package:shareqrcode/widgets/show_black_box.dart';

class CreateLink extends StatefulWidget {
  const CreateLink({Key? key}) : super(key: key);

  @override
  State<CreateLink> createState() => _CreateLinkState();
}

class _CreateLinkState extends State<CreateLink> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('สร้างที่เก็บ Link'),
      ),
      body: Column(
        children: [
          ShowBlackBox(title: 'ส่วนตัว', pressFunc: () {}),
          ShowBlackBox(title: 'สาธาระณะ', pressFunc: () {}),
          
        ],
      ),
    );
  }
}
