import 'package:flutter/material.dart';
import 'package:food_delivery_app/controller/cart_controller.dart';
import 'package:food_delivery_app/routes/router_helper.dart';
import 'package:get/get.dart';
import 'controller/popular_product_controller.dart';
import 'controller/recommend_product_controller.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(
        builder: (_) => GetBuilder<RecommendedProductController>(
            builder: (_) => GetMaterialApp(
                  title: 'Flutter Demo',
                  //home: SplashPage(),
                  debugShowCheckedModeBanner: false,
                  getPages: RouterHelper.routes,
                  initialRoute: RouterHelper.getSplashRoute(),
                )));
  }
}
