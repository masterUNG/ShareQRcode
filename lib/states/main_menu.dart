import 'package:flutter/material.dart';
import 'package:shareqrcode/states/create_link.dart';
import 'package:shareqrcode/states/process_scan_qr.dart';
import 'package:shareqrcode/widgets/create_product_live.dart';
import 'package:shareqrcode/widgets/show_black_box.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  String title = 'สร้างสินค้า Live สด';
  var subTitles = <String>[
    'สร้าง Link',
    'สแกน',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Main Menu'),
      ),
      body: Column(
        children: [
          ShowBlackBox(
            title: title,
            pressFunc: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateProductLive(),
                )),
          ),
          ShowBlackBox(
            title: subTitles[0],
            pressFunc: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateLink(),
                )),
          ),
          ShowBlackBox(
            title: subTitles[1],
            pressFunc: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProcessScanQR(),)),
          ),
        ],
      ),
    );
  }
}
