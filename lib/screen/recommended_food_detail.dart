import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/cart_controller.dart';
import '../controller/popular_product_controller.dart';
import '../controller/recommend_product_controller.dart';
import '../resources/AppColors.dart';
import '../resources/app_constants.dart';
import '../resources/dimensions.dart';
import '../routes/router_helper.dart';
import '../widget/app_icon.dart';
import '../widget/big_text.dart';
import '../widget/expandable_text.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String fromPage;
  const RecommendedFoodDetail(
      {Key? key, required this.pageId, required this.fromPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var recommendProduct =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(recommendProduct, Get.find<CartController>());

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            backgroundColor: Colors.yellowAccent,
            expandedHeight: 300,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => fromPage == 'fromCartPage'
                      ? Get.toNamed(RouterHelper.getCartPageRoute())
                      : Get.toNamed(RouterHelper.getInitRoute()),
                  child: const Icon(
                    Icons.clear,
                    color: CupertinoColors.black,
                  ),
                ),
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
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(Dimensions.height20),
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius20),
                      topLeft: Radius.circular(Dimensions.radius20),
                    )),
                child: Center(
                  child: BigText(
                      text: recommendProduct.name!, size: Dimensions.font26),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
              '${AppConstants.BASE_URL}${AppConstants.UPLOAD_URL}${recommendProduct.img!}',
              width: double.maxFinite,
              fit: BoxFit.cover,
            )),
          ),
          SliverToBoxAdapter(
            child: Column(children: [
              Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width20, right: Dimensions.width20),
                  child: ExpandableTextWidget(
                    text: recommendProduct.description!,
                  ))
            ]),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width20 * 3.5,
                    right: Dimensions.width20 * 3.5,
                    top: Dimensions.height10,
                    bottom: Dimensions.height10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => controller.setQuantity(false),
                      child: AppIcon(
                        size: Dimensions.iconSize24,
                        icon: Icons.remove,
                        iconColor: Colors.white,
                        bgColor: AppColors.mainColor,
                      ),
                    ),
                    BigText(
                      text:
                          "\$ ${recommendProduct.price} X ${controller.cartItem}",
                      color: AppColors.mainBlackColor,
                      size: Dimensions.font26,
                    ),
                    GestureDetector(
                      onTap: () => controller.setQuantity(true),
                      child: AppIcon(
                        size: Dimensions.iconSize24,
                        icon: Icons.add,
                        iconColor: Colors.white,
                        bgColor: AppColors.mainColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
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
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white),
                        child: const Icon(
                          Icons.favorite,
                          color: AppColors.mainColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.addItem(recommendProduct);
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
                            text: "\$ ${recommendProduct.price} | Add to cart",
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )),
            ],
          );
        },
      ),
    );
  }
}
