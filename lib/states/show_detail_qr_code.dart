// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shareqrcode/models/product_model.dart';

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
      body: Text('${productModel!.qrCode}'),
    );
  }
}
