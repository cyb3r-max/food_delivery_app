import 'package:food_delivery_app/widget/small_text.dart';
import 'package:flutter/cupertino.dart';

class BottomListWidgetIconText extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Color iconColor;
  const BottomListWidgetIconText(
      {Key? key,
      required this.iconData,
      required this.text,
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: iconColor,
          size: 12,
        ),
        SizedBox(
          width: 5,
        ),
        SmallText(text: text)
      ],
    );
  }
}
