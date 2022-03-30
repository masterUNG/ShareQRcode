import 'package:flutter/material.dart';
import 'package:shareqrcode/widgets/show_black_box.dart';
import 'package:shareqrcode/widgets/show_form.dart';

class CreateProductLive extends StatefulWidget {
  const CreateProductLive({Key? key}) : super(key: key);

  @override
  State<CreateProductLive> createState() => _CreateProductLiveState();
}

class _CreateProductLiveState extends State<CreateProductLive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('สร้างสินค้า Live สด'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
        behavior: HitTestBehavior.opaque,
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            children: [
              ShowBlackBox(
                iconData: Icons.add_a_photo,
                title: 'รูป',
                pressFunc: () {},
              ),
              ShowForm(
                width: constraints.maxWidth,
                label: 'ข้อความ',
                changeFunc: (String string) {},
              ),
              ShowForm(
                width: constraints.maxWidth,
                label: 'ราคา',
                changeFunc: (String string) {},
              ),
              ShowForm(
                width: constraints.maxWidth,
                label: 'จำนวน',
                changeFunc: (String string) {},
              ),
              ShowBlackBox(
                title: 'link ติดต่อ',
                pressFunc: () {},
              ),
               ShowBlackBox(
                title: 'กดเพื่อสร้าง สินค้า',
                pressFunc: () {},
              ),
            ],
          );
        }),
      ),
    );
  }
}
