// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ChooseOrCreateSubTable extends StatelessWidget {
  final String sourceTable;
  const ChooseOrCreateSubTable({
    Key? key,
    required this.sourceTable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(sourceTable,),)
    );
  }
}
