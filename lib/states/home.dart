import 'package:flutter/material.dart';
import 'package:shareqrcode/states/create_qr_code.dart';
import 'package:shareqrcode/states/work_qr_code.dart';
import 'package:shareqrcode/widgets/showbutton.dart';

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ShowButton(
            label: 'การใช้งาน',
            pressFunc: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WorkQRcode(),
                )),
          ),
          ShowButton(
            label: 'การสร้างรหัส',
            pressFunc: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateQRcode(),
                )),
          )
        ],
      ),
    );
  }
}
