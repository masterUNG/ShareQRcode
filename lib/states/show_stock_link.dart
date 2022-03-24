import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShowStockLink extends StatefulWidget {
  const ShowStockLink({
    Key? key,
  }) : super(key: key);

  @override
  State<ShowStockLink> createState() => _ShowStockLinkState();
}

class _ShowStockLinkState extends State<ShowStockLink> {
  @override
  void initState() {
    super.initState();
    readFavoricLink();
  }

  Future<void> readFavoricLink() async {
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('dataCode')
        .doc(user!.uid)
        .collection('favoritlink')
        .get()
        .then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show Stock Link'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
    );
  }
}
