import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/popular_product_repo.dart';
import '../model/popular_product_model.dart';
import '../resources/AppColors.dart';
import 'cart_controller.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});

  List<ProductsModel> _popularProductList = [];
  List<ProductsModel> get popularProductList => _popularProductList;
  late CartController _cartController;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get cartItem => _inCartItems + _quantity;
  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      print(popularProductList);
      _isLoaded = true;
      update();
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
      print("increment" + _quantity.toString());
    } else {
      _quantity = checkQuantity(_quantity - 1);
      print('dec' + _quantity.toString());
    }
    //isIncrement ? checkQuantity(_quantity++) : checkQuantity(_quantity--);
    update();
  }

  int checkQuantity(int quantity) {
    if (_inCartItems + quantity < 0) {
      Get.snackbar("Warning !", "Your item count is 0",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if (_inCartItems + quantity > 20) {
      print("u just fucked up");
      Get.snackbar("Warming !", "You can't order more than 20 piece",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductsModel productsModel, CartController cartController) {
    _quantity = 0;
    _inCartItems = 0;
    _cartController = cartController;

    var exist = false;
    exist = _cartController.existInCart(productsModel);
    if (exist) {
      _inCartItems = _cartController.getQuantity(productsModel);
    }
  }

  void addItem(ProductsModel productsModel) {
    //if (_quantity > 0) {
    _cartController.addItem(productsModel, _quantity);
    _quantity = 0;
    _inCartItems = _cartController.getQuantity(productsModel);
    _cartController.items.forEach((key, value) {
      print("ID is " +
          value.id.toString() +
          " added to cart quantity" +
          value.quantity.toString());
    });
    update();
    // } else {
    //   //Get.snackbar("Warning!", "Add at least one item");
    // }
  }

  int get totalItems {
    return _cartController.totalItems;
  }
}
