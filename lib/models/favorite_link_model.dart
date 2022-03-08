import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FavoriteLinkModel {
  final String nameItem;
  final String urlItem;
  FavoriteLinkModel({
    required this.nameItem,
    required this.urlItem,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nameItem': nameItem,
      'urlItem': urlItem,
    };
  }

  factory FavoriteLinkModel.fromMap(Map<String, dynamic> map) {
    return FavoriteLinkModel(
      nameItem: (map['nameItem'] ?? '') as String,
      urlItem: (map['urlItem'] ?? '') as String,
    );
  }

  factory FavoriteLinkModel.fromJson(String source) => FavoriteLinkModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
