import 'package:ecommerce/models/product.dart';

class Category {
  var id;
  var name;
  var avatar;
  List<Product>? products;

  Category({
    required this.id,
    required this.name,
    required this.avatar,
    required this.products,
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
