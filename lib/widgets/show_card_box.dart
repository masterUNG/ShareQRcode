// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shareqrcode/utility/my_constant.dart';
import 'package:shareqrcode/widgets/show_image.dart';
import 'package:shareqrcode/widgets/show_text.dart';

class ShowCardBox extends StatelessWidget {
  final String label;
  final String pathImage;
  final Function() pressFunc;
  const ShowCardBox({
    Key? key,
    required this.label,
    required this.pathImage,
    required this.pressFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: InkWell(onTap: pressFunc,
        child: Card(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 100,height: 100,
                child: ShowImage(path: pathImage),
              ),
              ShowText(label: label, textStyle: MyConstant().h2Style(),),
            ],
          ),
        ),
      ),
    );
  }
}
