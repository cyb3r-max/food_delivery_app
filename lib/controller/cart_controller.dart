import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../data/repository/cart_repo.dart';
import '../model/cart_model.dart';
import '../model/popular_product_model.dart';
import '../resources/AppColors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;
  List<CartModel> storageItems = [];

  void addItem(ProductsModel productsModel, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(productsModel.id!)) {
      if (kDebugMode) {
        print("quantity added $quantity");
      }
      _items.update(productsModel.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            quantity: value.quantity! + quantity,
            img: value.img,
            isExist: true,
            time: DateTime.now().toString(),
            product: productsModel);
      });
      if (totalQuantity <= 0) {
        _items.remove(productsModel.id!);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(productsModel.id!, () {
          if (kDebugMode) {
            print("Item added $quantity");
          }
          _items.forEach((key, value) {
            if (kDebugMode) {
              print("quantity is ${value.quantity}");
            }
          });
          return CartModel(
              id: productsModel.id,
              name: productsModel.name,
              price: productsModel.price,
              quantity: quantity,
              img: productsModel.img,
              isExist: true,
              time: DateTime.now().toString(),
              product: productsModel);
        });
      } else {
        Get.snackbar("Warning!", "Add at least one item",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.mainColor);
      }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(ProductsModel productsModel) =>
      _items.containsKey(productsModel.id) ? true : false;

  int getQuantity(ProductsModel productsModel) {
    var quantity = 0;
    if (_items.containsKey(productsModel.id)) {
      _items.forEach((key, value) {
        if (key == productsModel.id) {
          quantity = value.quantity!;
        }
      });
    }
    if (kDebugMode) {
      print(quantity);
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) => e.value).toList();
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, value) => total += value.quantity! * value.price!);
    return total;
  }

  List<CartModel> getCartData() {
    setCartItems = cartRepo.getCartList();
    return storageItems;
  }

  set setCartItems(List<CartModel> items) {
    storageItems = items;
    print("lenghtn of Cart Items:" + storageItems.length.toString());
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToCartHisory() {
    cartRepo.addToCartHistory();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistory();
  }

  set setItems(Map<int, CartModel> setItems) {
    _items = {};
    _items = setItems;
    print("SetItems called");
  }

  void addToCartList() {
    cartRepo.addToCartList(getItems);
    update();
    print("add to CartLIst called" + getItems.toString());
  }
}
