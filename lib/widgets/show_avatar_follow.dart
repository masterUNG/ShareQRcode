// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ShowAvatarFollow extends StatelessWidget {
  final ImageProvider imageProvider;
  final Function() tapAvatarFunc;
  final Function() pressAddFunc;
  const ShowAvatarFollow({
    Key? key,
    required this.imageProvider,
    required this.tapAvatarFunc,
    required this.pressAddFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 66,
      height: 66,
      child: Stack(
        children: [
          InkWell(
            onTap: tapAvatarFunc,
            child: CircleAvatar(radius: 100,
              backgroundImage: imageProvider,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: IconButton(
              onPressed: pressAddFunc,
              icon: const Icon(Icons.add_box),
            ),
          ),
        ],
      ),
    );
  }
}
