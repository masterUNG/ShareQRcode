import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  
  final String name;
  final String urlAvatar;
  UserModel({
    required this.name,
    required this.urlAvatar,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'urlAvatar': urlAvatar,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: (map['name'] ?? '') as String,
      urlAvatar: (map['urlAvatar'] ?? '') as String,
    );
  }

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
