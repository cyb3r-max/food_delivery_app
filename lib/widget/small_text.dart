import 'package:flutter/material.dart';

import '../resources/dimensions.dart';

class SmallText extends StatelessWidget {
  Color? color;
  String text;
  double size;
  final double height;

  SmallText(
      {Key? key,
      this.color = const Color(0xFFccc7c5),
      required this.text,
      this.size = 12,
      this.height = 1.2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: size == 12 ? Dimensions.font12 : size,
        height: height,
        //overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
