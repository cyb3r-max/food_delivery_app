import 'package:flutter/material.dart';
import 'package:food_delivery_app/widget/small_text.dart';
import '../resources/AppColors.dart';
import '../resources/dimensions.dart';
import 'big_text.dart';
import 'bottom_list_widget_icon_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimensions.font26,
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        SmallText(text: "With chinese characteristics"),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          children: [
            Wrap(
                children: List.generate(
                    5,
                    (index) => Icon(
                          Icons.star,
                          color: AppColors.mainColor,
                          size: Dimensions.height15,
                        ))),
            SizedBox(
              width: Dimensions.width10,
            ),
            SmallText(text: '4.5'),
            SizedBox(
              width: Dimensions.width10,
            ),
            SmallText(text: '1230'),
            SizedBox(
              width: Dimensions.width10,
            ),
            SmallText(text: 'Comments')
          ],
        ),
        SizedBox(
          height: Dimensions.width10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            BottomListWidgetIconText(
                iconData: Icons.circle,
                text: 'Normal',
                iconColor: AppColors.iconColor1),
            BottomListWidgetIconText(
                iconData: Icons.location_on,
                text: '1.76 km',
                iconColor: AppColors.mainColor),
            BottomListWidgetIconText(
                iconData: Icons.access_time_rounded,
                text: '32 min away',
                iconColor: AppColors.iconColor2),
          ],
        ),
      ],
    );
  }
}
