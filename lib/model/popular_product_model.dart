class Product {
  int? _totalSize, _typeId, _offset;
  late List<ProductsModel> _products;
  List<ProductsModel> get products => _products;
  Product(
      {required totalSize,
      required typeId,
      required offset,
      required products}) {
    _totalSize = totalSize;
    _offset = offset;
    _typeId = typeId;
    _products = products;
  }

  Product.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = <ProductsModel>[];
      json['products'].forEach((v) {
        _products.add(ProductsModel.fromJson(v));
      });
    }
  }
}

class ProductsModel {
  int? id, price, stars, typeId;
  String? name, description, img, location, createdAt, updatedAt;

  ProductsModel(
      {this.id,
      this.price,
      this.stars,
      this.typeId,
      this.name,
      this.description,
      this.img,
      this.location,
      this.createdAt,
      this.updatedAt});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json[''];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "price": this.price,
      "description": this.description,
      "stars": this.stars,
      "": this.location,
      "created_at": this.createdAt,
      "updated_at": this.updatedAt,
      "img": this.img,
      "type_id": this.typeId
    };
  }
}
