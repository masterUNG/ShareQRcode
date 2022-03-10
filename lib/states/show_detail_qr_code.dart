// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shareqrcode/models/product_model.dart';
import 'package:shareqrcode/utility/my_constant.dart';
import 'package:shareqrcode/utility/my_dialog.dart';
import 'package:shareqrcode/widgets/show_image.dart';
import 'package:shareqrcode/widgets/show_text.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowDetailQRcode extends StatefulWidget {
  final ProductModel? productModel;
  const ShowDetailQRcode({
    Key? key,
    this.productModel,
  }) : super(key: key);

  @override
  State<ShowDetailQRcode> createState() => _ShowDetailQRcodeState();
}

class _ShowDetailQRcodeState extends State<ShowDetailQRcode> {
  ProductModel? productModel;

  @override
  void initState() {
    super.initState();
    productModel = widget.productModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            showImage(),
            ShowText(
              label: productModel!.nameProduct,
              textStyle: MyConstant().h2Style(),
            ),
            ShowText(
              label: productModel!.detailProduct,
              textStyle: MyConstant().h3Style(),
            ),
            SizedBox(
              width: 250,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: productModel!.titleItems.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    String urlLink = productModel!.linkItems[index];
                    print('You Click ==>> $urlLink');
                    processOpenLink(urlLink);
                  },
                  child: Card(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ShowText(label: productModel!.titleItems[index]),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showImage() {
    return productModel!.pathImages.isEmpty
        ? const ShowImage(path: 'images/image4.png')
        : Image.network(productModel!.pathImages[0]);
  }

  Future<void> processOpenLink(String urlLink) async {
    if (await canLaunch(urlLink)) {
      await launch(urlLink);
    } else {
      MyDialog(context: context).normalDialog('Have Problem ?', 'Link False',
          'OK', () => Navigator.pop(context), 'images/image2.png');
    }
  }
}
