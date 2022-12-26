import 'package:food_delivery_app/resources/AppColors.dart';
import 'package:food_delivery_app/resources/dimensions.dart';
import 'package:food_delivery_app/widget/small_text.dart';
import 'package:flutter/material.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String visible, invisible;
  bool hidden = true;
  double textHeight = Dimensions.screenHeight / 2;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > 200) {
      visible = widget.text.substring(0, 200);
      invisible = widget.text.substring(201, widget.text.length);
    } else {
      visible = widget.text;
      invisible = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: invisible == ""
          ? SmallText(
              text: visible,
              color: AppColors.paraColor,
              size: Dimensions.font16,
              height: 1.8,
            )
          : Column(
              children: [
                SmallText(
                  text: hidden ? visible + "..." : visible + invisible,
                  color: AppColors.paraColor,
                  size: Dimensions.font16,
                  height: 1.8,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hidden = !hidden;
                      print("fuck");
                    });
                  },
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(hidden ? "Show More" : "Show less"),
                      Icon(hidden
                          ? Icons.arrow_drop_down_circle_sharp
                          : Icons.arrow_drop_up_outlined)
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
