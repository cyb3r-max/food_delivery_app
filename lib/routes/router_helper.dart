import 'package:get/get.dart';

import '../screen/cart_items/cart_page.dart';
import '../screen/home/bottomBar.dart';
import '../screen/popular_screen.dart';
import '../screen/recommended_food_detail.dart';
import '../screen/splash_screen.dart';

class RouterHelper {
  static const String initRoute = "/";
  static const String splashPageRoute = "/splash-screen";
  static const String popularPageRoute = "/popular-food";
  static const String recommendedPageRoute = "/recommended-food";
  static const String cartPageRoute = "/cart-page";

  static String getInitRoute() => '$initRoute';
  static String getSplashRoute() => '$splashPageRoute';
  static String getPopularPageRoute(int pageId, String fromPage) =>
      '$popularPageRoute?pageId=$pageId&fromPage=$fromPage';
  static String getRecommendedPageRoute(int pageId, String fromPage) =>
      '$recommendedPageRoute?pageId=$pageId&fromPage=$fromPage';
  static String getCartPageRoute() => cartPageRoute;

  static List<GetPage> routes = [
    GetPage(name: splashPageRoute, page: () => SplashPage()),
    GetPage(name: initRoute, page: () => BottomBar()),
    GetPage(
        name: popularPageRoute,
        page: () {
          var pageId = Get.parameters['pageId'];
          var fromPage = Get.parameters['fromPage'];
          return PopularFoods(pageId: int.parse(pageId!), fromPage: fromPage!);
        },
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: recommendedPageRoute,
        page: () {
          var pageId = Get.parameters['pageId'];
          var fromPage = Get.parameters['fromPage'];
          return RecommendedFoodDetail(
              pageId: int.parse(pageId!), fromPage: fromPage!);
        },
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: cartPageRoute,
        page: () {
          return const CartPage();
        },
        transition: Transition.rightToLeftWithFade),
  ];
}
