import 'package:flutter/material.dart';

import '../controller/cart_controller.dart';
import '../controller/popular_product_controller.dart';
import '../resources/AppColors.dart';
import '../resources/app_constants.dart';
import '../resources/dimensions.dart';
import '../routes/router_helper.dart';
import '../widget/app_column.dart';
import '../widget/app_icon.dart';
import '../widget/big_text.dart';
import '../widget/bottom_list_widget_icon_text.dart';
import '../widget/expandable_text.dart';
import 'package:get/get.dart';

class PopularFoods extends StatelessWidget {
  final int pageId;
  final String fromPage;
  PopularFoods({required this.pageId, Key? key, required this.fromPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    print(pageId.toString());
    print(product.name.toString());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImg,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            '${AppConstants.BASE_URL}${AppConstants.UPLOAD_URL}${product.img!}'))),
              )),
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () => fromPage == 'fromCartPage'
                          ? Get.toNamed(RouterHelper.getCartPageRoute())
                          : Get.toNamed(RouterHelper.getInitRoute()),
                      child: const AppIcon(icon: Icons.arrow_back_ios)),
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return Stack(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.toNamed(RouterHelper.getCartPageRoute());
                            },
                            child: AppIcon(icon: Icons.shopping_cart_outlined)),
                        Get.find<PopularProductController>().totalItems == 1
                            ? Container()
                            : Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.mainColor,
                                      //shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: BigText(
                                      text: Get.find<PopularProductController>()
                                          .totalItems
                                          .toString(),
                                      size: 12),
                                ),
                              ),
                      ],
                    );
                  }),
                ],
              )),
          Positioned(
              left: 0,
              right: 0,
              top: Dimensions.popularFoodImg - Dimensions.height20,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width30,
                    right: Dimensions.width30,
                    top: Dimensions.height20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius20),
                        topLeft: Radius.circular(Dimensions.radius20)),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(
                      text: product.name!,
                    ),
                    SizedBox(
                      height: Dimensions.height15,
                    ),
                    BigText(text: 'Introduction'),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandableTextWidget(text: product.description!),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (popularProductControl) {
        return Container(
            height: Dimensions.bottomBarHeight,
            padding: EdgeInsets.only(
                top: Dimensions.height30,
                bottom: Dimensions.height30,
                left: Dimensions.width20,
                right: Dimensions.width20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2),
                ),
                color: AppColors.buttonbgColor),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width30,
                      right: Dimensions.width30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => popularProductControl.setQuantity(false),
                        child: const Icon(
                          Icons.remove,
                          color: AppColors.signColor,
                        ),
                      ),
                      SizedBox(width: Dimensions.width20 / 4),
                      BigText(text: popularProductControl.cartItem.toString()),
                      SizedBox(width: Dimensions.width20 / 4),
                      GestureDetector(
                        onTap: () {
                          popularProductControl.setQuantity(true);
                        },
                        child: Icon(
                          Icons.add,
                          color: AppColors.signColor,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    popularProductControl.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        left: Dimensions.width30,
                        right: Dimensions.width30),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor),
                    child: BigText(
                      text: "\$ ${product.price} | Add to cart",
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ));
      }),
    );
  }
}
