import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/widget/emptyPage.dart';
import 'package:get/get.dart';

import '../../controller/cart_controller.dart';
import '../../controller/popular_product_controller.dart';
import '../../controller/recommend_product_controller.dart';
import '../../resources/AppColors.dart';
import '../../resources/app_constants.dart';
import '../../resources/dimensions.dart';
import '../../routes/router_helper.dart';
import '../../widget/app_icon.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                      bgColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.toNamed(RouterHelper.getInitRoute());
                          },
                          child: AppIcon(
                            icon: Icons.home_sharp,
                            iconColor: Colors.white,
                            bgColor: AppColors.mainColor,
                            iconSize: Dimensions.iconSize24,
                          )),
                      SizedBox(
                        width: Dimensions.width20,
                      ),
                      AppIcon(
                        icon: Icons.shopping_cart_outlined,
                        iconColor: Colors.white,
                        bgColor: AppColors.mainColor,
                        iconSize: Dimensions.iconSize24,
                      )
                    ],
                  )
                ],
              ),
              GetBuilder<CartController>(builder: (_cartController) {
                return _cartController.getItems.isNotEmpty
                    ? Expanded(
                        child: GetBuilder<CartController>(
                          builder: (controller) {
                            var _cartList = controller.getItems;
                            return ListView.builder(
                                itemCount: _cartList.length,
                                itemBuilder: (_, index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                      right: Dimensions.width20,
                                      left: Dimensions.width20,
                                      top: Dimensions.height10,
                                    ),
                                    width: double.maxFinite,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            var popularProductItem = Get.find<
                                                    PopularProductController>()
                                                .popularProductList
                                                .indexOf(
                                                    _cartList[index].product!);

                                            if (popularProductItem >= 0) {
                                              Get.toNamed(RouterHelper
                                                  .getPopularPageRoute(
                                                      popularProductItem,
                                                      'fromCartPage'));
                                            } else {
                                              var recommendProductItem = Get.find<
                                                      RecommendedProductController>()
                                                  .recommendedProductList
                                                  .indexOf(_cartList[index]
                                                      .product!);

                                              recommendProductItem < 0
                                                  ? Get.snackbar(
                                                      "History Product",
                                                      "Item didn't match",
                                                      backgroundColor:
                                                          AppColors.mainColor,
                                                      colorText:
                                                          CupertinoColors.white)
                                                  : Get.toNamed(RouterHelper
                                                      .getRecommendedPageRoute(
                                                          recommendProductItem,
                                                          'fromCartPage'));
                                            }
                                          },
                                          child: Container(
                                              height: Dimensions.height20 * 5,
                                              width: Dimensions.height20 * 5,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          AppConstants
                                                                  .BASE_URL +
                                                              AppConstants
                                                                  .UPLOAD_URL +
                                                              controller
                                                                  .getItems[
                                                                      index]
                                                                  .img!)))),
                                        ),
                                        SizedBox(
                                          width: Dimensions.width20,
                                        ),
                                        Expanded(
                                            child: SizedBox(
                                                height: Dimensions.height20 * 5,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    BigText(
                                                        text: _cartList[index]
                                                            .name
                                                            .toString()),
                                                    SmallText(
                                                      text: "spicy",
                                                      color: Colors.black54,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        BigText(
                                                            text:
                                                                "\$ ${_cartList[index].price.toString()}"),
                                                        Container(
                                                          padding: EdgeInsets.only(
                                                              top: Dimensions
                                                                  .height10,
                                                              bottom: Dimensions
                                                                  .height10,
                                                              left: Dimensions
                                                                  .width10,
                                                              right: Dimensions
                                                                  .width10),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      Dimensions
                                                                          .radius20),
                                                              color:
                                                                  Colors.white),
                                                          child: Row(
                                                            children: [
                                                              GestureDetector(
                                                                //onTap: () => popularProductControl.setQuantity(false),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () => controller.addItem(
                                                                      _cartList[
                                                                              index]
                                                                          .product!,
                                                                      -1),
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .remove,
                                                                    color: AppColors
                                                                        .signColor,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: Dimensions
                                                                          .width20 /
                                                                      4),
                                                              BigText(
                                                                  text: _cartList[
                                                                          index]
                                                                      .quantity
                                                                      .toString()),
                                                              SizedBox(
                                                                  width: Dimensions
                                                                          .width20 /
                                                                      4),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  controller.addItem(
                                                                      _cartList[
                                                                              index]
                                                                          .product!,
                                                                      1);
                                                                },
                                                                child:
                                                                    const Icon(
                                                                  Icons.add,
                                                                  color: AppColors
                                                                      .signColor,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                )))
                                      ],
                                    ),
                                  );
                                });
                          },
                        ),
                      )
                    : EmptyPage(text: " ");
              })
            ],
          ),
        ),
        bottomNavigationBar: GetBuilder<CartController>(builder: (cartControl) {
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
              child: cartControl.getItems.isNotEmpty
                  ? Row(
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
                          child: Row(
                            children: [
                              SizedBox(width: Dimensions.width20 / 4),
                              BigText(
                                text: "Total price: ",
                                color: Colors.black54,
                              ),
                              BigText(
                                text: "\$${cartControl.totalAmount}",
                                color: Colors.redAccent,
                              ),
                              SizedBox(width: Dimensions.width20 / 4),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            cartControl.addToCartHisory();
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
                              text: "Checkout",
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    )
                  : Container());
        }));
  }
}
