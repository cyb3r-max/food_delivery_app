import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/popular_product_controller.dart';
import '../controller/recommend_product_controller.dart';
import '../routes/router_helper.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Animation<double> splashAnimation;
  late AnimationController splashAnimationController;
  _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    _loadResources();
    super.initState();
    splashAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..forward();
    splashAnimation = CurvedAnimation(
        parent: splashAnimationController, curve: Curves.bounceOut);
    Timer(
        Duration(seconds: 3), () => Get.offNamed(RouterHelper.getInitRoute()));
  }

  @override
  void dispose() {
    splashAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var scWidth = MediaQuery.of(context).size.width;
    var scHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: splashAnimationController,
              child: Image.asset(
                'asset/image/apple.jpeg',
                width: scWidth * .4,
                height: scWidth * .4,
              ),
            ),
            Image.asset(
              'asset/image/samsung.jpg',
              width: scWidth * .8,
              height: scHeight * .2,
            )
          ],
        ),
      ),
    );
  }
}
