import 'package:food_delivery_app/model/popular_product_model.dart';

class CartModel {
  int? id, price;
  String? name, img;
  int? quantity;
  bool? isExist;
  String? time;
  ProductsModel? product;

  CartModel(
      {this.id,
      this.price,
      this.name,
      this.img,
      this.quantity,
      this.isExist,
      this.time,
      this.product});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    time = json['time'];
    product = ProductsModel.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "name": this.name,
        "price": this.price,
        "img": this.img,
        "quantity": this.quantity,
        "isExist": this.isExist,
        "time": this.time,
        "product": this.product?.toJson()!
      };
}
