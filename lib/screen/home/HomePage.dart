import 'package:flutter/material.dart';
import '../../resources/AppColors.dart';
import '../../resources/dimensions.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';
import 'home_page_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: Dimensions.height15, bottom: Dimensions.height20),
              padding: EdgeInsets.only(
                  left: Dimensions.width15, right: Dimensions.width15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    BigText(text: 'Country'),
                    Row(
                      children: [
                        SmallText(
                          text: "City",
                          color: Colors.black54,
                        ),
                        const Icon(
                          Icons.arrow_drop_down_outlined,
                          size: 12,
                        )
                      ],
                    )
                  ]),
                  Center(
                    child: Container(
                      width: Dimensions.height45,
                      height: Dimensions.height45,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor),
                      child: Icon(
                        Icons.search_rounded,
                        size: Dimensions.iconSize24,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Expanded(child: SingleChildScrollView(child: HomePageBody()))
          ],
        ),
      ),
    );
  }
}
