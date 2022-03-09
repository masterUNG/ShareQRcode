// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String nameProduct;
  final String detailProduct;
  final List<String> titleItems;
  final List<String> linkItems;
  final List<String> pathImages;
  final String qrCode;
  final Timestamp timestamp;
  ProductModel({
    required this.nameProduct,
    required this.detailProduct,
    required this.titleItems,
    required this.linkItems,
    required this.pathImages,
    required this.qrCode,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nameProduct': nameProduct,
      'detailProduct': detailProduct,
      'titleItems': titleItems,
      'linkItems': linkItems,
      'pathImages': pathImages,
      'qrCode': qrCode,
      'timestamp': timestamp,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      nameProduct: (map['nameProduct'] ?? '') as String,
      detailProduct: (map['detailProduct'] ?? '') as String,
      titleItems: List<String>.from((map['titleItems'] ?? const <String>[]) as List<String>),
      linkItems: List<String>.from((map['linkItems'] ?? const <String>[]) as List<String>),
      pathImages: List<String>.from((map['pathImages'] ?? const <String>[]) as List<String>),
      qrCode: (map['qrCode'] ?? '') as String,
      timestamp: (map['timestamp']),
    );
  }

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
