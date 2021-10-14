import 'package:ecommerce/models/product.dart';

class Category {
  var id;
  var name;
  var avatar;
  List<Product>? products;

  Category({
    this.id,
    this.name,
    this.avatar,
    this.products,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      products: json['products'],
    );
  }
}
