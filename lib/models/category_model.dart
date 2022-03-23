// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String name;
  final String owner;
  final Timestamp dateTime;
  CategoryModel({
    required this.name,
    required this.owner,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'owner': owner,
      'dateTime': dateTime,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      name: (map['name'] ?? '') as String,
      owner: (map['owner'] ?? '') as String,
      dateTime: (map['dateTime']),
    );
  }

  factory CategoryModel.fromJson(String source) => CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
