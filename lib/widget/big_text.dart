import 'package:food_delivery_app/resources/AppColors.dart';
import 'package:food_delivery_app/resources/dimensions.dart';
import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  Color? color;
  String text;
  double size;
  TextOverflow textOverflow;

  BigText(
      {Key? key,
      this.color = AppColors.mainBlackColor,
      required this.text,
      this.size = 20,
      this.textOverflow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: textOverflow,
      style: TextStyle(
          color: color,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
          fontSize: size == 20 ? Dimensions.font20 : size),
    );
  }
}
