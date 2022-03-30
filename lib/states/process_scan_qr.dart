import 'package:flutter/material.dart';
import 'package:shareqrcode/widgets/show_black_box.dart';
import 'package:shareqrcode/widgets/show_form.dart';
import 'package:shareqrcode/widgets/show_image.dart';

class ProcessScanQR extends StatefulWidget {
  const ProcessScanQR({Key? key}) : super(key: key);

  @override
  State<ProcessScanQR> createState() => _ProcessScanQRState();
}

class _ProcessScanQRState extends State<ProcessScanQR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Process Scan'),
      ),
      body: Center(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: const ShowImage(
                path: 'images/icon.png',
                width: 200,
              ),
            ),
            ShowForm(label: 'QR code', changeFunc: (String string) {}, width: 250,),
            ShowBlackBox(title: 'OK', pressFunc: (){}),
          ],
        ),
      ),
    );
  }
}
