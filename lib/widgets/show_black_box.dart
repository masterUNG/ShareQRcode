// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shareqrcode/utility/my_constant.dart';
import 'package:shareqrcode/widgets/show_text.dart';

class ShowBlackBox extends StatelessWidget {
  final String title;
  final Function() pressFunc;
  final IconData? iconData;
  final Widget? iconButtonWidget;
  const ShowBlackBox({
    Key? key,
    required this.title,
    required this.pressFunc,
    this.iconData,
    this.iconButtonWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyConstant.myBlack,
        borderRadius: BorderRadius.circular(30),
      ),
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            trailing: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [ iconButtonWidget ?? const SizedBox(), 
                  IconButton(
                      onPressed: pressFunc,
                      icon: Icon(
                        iconData ?? Icons.arrow_forward_ios,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
            title: ShowText(
              label: title,
              textStyle: MyConstant().h2WhiteStyle(),
            ),
          ),
        ],
      ),
    );
  }
}
