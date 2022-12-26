import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/controller/cart_controller.dart';
import 'package:food_delivery_app/model/cart_model.dart';
import 'package:food_delivery_app/resources/AppColors.dart';
import 'package:food_delivery_app/resources/app_constants.dart';
import 'package:food_delivery_app/resources/dimensions.dart';
import 'package:food_delivery_app/widget/big_text.dart';
import 'package:food_delivery_app/widget/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../routes/router_helper.dart';

class CartHistoryPage extends StatelessWidget {
  const CartHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemPerOrder = Map();
    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    List<int> cartOrderPerItemToList() {
      return cartItemPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeList() {
      return cartItemPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> noOfItemsPerOrder = cartOrderPerItemToList();
    var saveCounter = 0;
    return Scaffold(
        body: Column(
      children: [
        Container(
          width: double.maxFinite,
          height: Dimensions.height10 * 9,
          padding: EdgeInsets.only(
              top: Dimensions.height30,
              left: Dimensions.width20,
              right: Dimensions.width20),
          color: AppColors.mainColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BigText(
                text: "Cart History",
                size: Dimensions.height30,
              ),
              GestureDetector(
                  onTap: () => {Get.toNamed(RouterHelper.getCartPageRoute())},
                  child: const Icon(Icons.shopping_cart))
            ],
          ),
        ),
        Expanded(
            child: Container(
          margin: EdgeInsets.only(
              bottom: Dimensions.height15,
              right: Dimensions.width15,
              left: Dimensions.width15),
          child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView(
                children: [
                  for (int i = 0; i < noOfItemsPerOrder.length; i++)
                    Container(
                      margin: EdgeInsets.only(bottom: Dimensions.height10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (() {
                            DateTime parseDate =
                                DateFormat("yyyy-MM-dd HH:mm:ss").parse(
                                    getCartHistoryList[saveCounter].time!);

                            var inputDate =
                                DateTime.parse(parseDate.toString());
                            var outputFormat = DateFormat("MM/dd/yyy HH:mm:ss");
                            var outputDate = outputFormat.format(inputDate);
                            return BigText(text: outputDate);
                          }()),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Wrap(
                                  direction: Axis.horizontal,
                                  children: List.generate(noOfItemsPerOrder[i],
                                      (index) {
                                    if (saveCounter <
                                        getCartHistoryList.length) {
                                      saveCounter++;
                                    }
                                    return index <= 2
                                        ? Container(
                                            margin: EdgeInsets.only(
                                                right: Dimensions.width10 / 2),
                                            height: 80,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius20 /
                                                            2),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        AppConstants.BASE_URL +
                                                            AppConstants
                                                                .UPLOAD_URL +
                                                            getCartHistoryList[
                                                                    saveCounter -
                                                                        1]
                                                                .img!))),
                                          )
                                        : Container();
                                  })),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SmallText(
                                    text: "Total",
                                    color: Colors.black,
                                  ),
                                  BigText(
                                      text: noOfItemsPerOrder[i].toString()),
                                  GestureDetector(
                                    onTap: () {
                                      var orderTime = cartOrderTimeList();
                                      Map<int, CartModel> oneMoreTimeMap = {};
                                      for (int j = 0;
                                          j < getCartHistoryList.length;
                                          j++) {
                                        if (getCartHistoryList[j].time ==
                                            orderTime[i]) {
                                          oneMoreTimeMap.putIfAbsent(
                                              getCartHistoryList[j].id!,
                                              () => CartModel.fromJson(
                                                  jsonDecode(jsonEncode(
                                                      getCartHistoryList[j]))));
                                          print("Product Info " +
                                              jsonEncode(
                                                  getCartHistoryList[j]));
                                        }
                                      }
                                      Get.find<CartController>().setItems =
                                          oneMoreTimeMap;
                                      Get.find<CartController>()
                                          .addToCartList();
                                      print("One more tapped");
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Dimensions.width10 / 3,
                                          vertical: Dimensions.height10 / 3),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius20 / 4),
                                          border: Border.all(
                                              width: 1,
                                              color: AppColors.mainColor)),
                                      child: SmallText(
                                        text: "One more",
                                        color: AppColors.mainColor,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )
                ],
              )),
        ))
      ],
    ));
  }
}
