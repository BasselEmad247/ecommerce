import 'dart:convert';

import 'package:ecommerce/models/category.dart';
import 'package:ecommerce/models/product.dart';
import 'package:http/http.dart' as http;

class Http {
  String allProducts = "https://retail.amit-learning.com/api/products/";
  String allCategories = "https://retail.amit-learning.com/api/categories/";

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(allProducts));

    if (response.statusCode == 200) {
      List<dynamic> productsJson = jsonDecode(response.body)["products"];

      List<Product> products = productsModel(productsJson);

      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse(allCategories));

    if (response.statusCode == 200) {
      List<dynamic> categoriesJson = jsonDecode(response.body)["categories"];

      List<Category> categories = categoriesModel(categoriesJson);

      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<Product> fetchProduct(int id) async {
    final response = await http.get(Uri.parse(allProducts + id.toString()));

    if (response.statusCode == 200) {
      dynamic productJson = jsonDecode(response.body)["product"];

      Product product = productModel(productJson);

      return product;
    } else {
      throw Exception('Failed to load product');
    }
  }

  Future<List<Product>> fetchCategory(int id) async {
    final response = await http.get(Uri.parse(allCategories + id.toString()));

    if (response.statusCode == 200) {
      dynamic categoryJson = jsonDecode(response.body)["category"];

      Category category = categoryModel(categoryJson);

      return category.products!;
    } else {
      throw Exception('Failed to load category');
    }
  }

  List<Product> productsModel(List<dynamic> productsJson) {
    List<Product> products = [];

    for (dynamic i in productsJson) {
      if (i["id"] == null ||
          i["title"] == null ||
          i["description"] == null ||
          i["price"] == null ||
          i["avatar"] == null) {
        continue;
      }
      Product product = Product(
          id: i["id"],
          name: i["name"],
          title: i["title"],
          category_id: i["category_id"],
          description: i["description"],
          price: i["price"],
          discount: i["discount"],
          discount_type: i["discount_type"],
          currency: i["currency"],
          in_stock: i["in_stock"],
          avatar: i["avatar"],
          price_final: i["price_final"],
          price_final_text: i["price_final_text"]);

      products.add(product);
    }
    return products;
  }

  List<Category> categoriesModel(List<dynamic> categoriesJson) {
    List<Category> categories = [];

    for (dynamic i in categoriesJson) {
      if (i["id"] == null || i["name"] == null || i["avatar"] == null) {
        continue;
      }
      Category category = Category(
          id: i["id"],
          name: i["name"],
          avatar: i["avatar"],
          products: i["products"]);

      categories.add(category);
    }
    return categories;
  }

  Product productModel(dynamic productJson) {
    Product product = Product(
        id: productJson["id"],
        name: productJson["name"],
        title: productJson["title"],
        category_id: productJson["category_id"],
        description: productJson["description"],
        price: productJson["price"],
        discount: productJson["discount"],
        discount_type: productJson["discount_type"],
        currency: productJson["currency"],
        in_stock: productJson["in_stock"],
        avatar: productJson["avatar"],
        price_final: productJson["price_final"],
        price_final_text: productJson["price_final_text"]);

    return product;
  }

  Category categoryModel(dynamic categoryJson) {
    List<Product> products = [];
    for (var i in categoryJson["products"]) {
      Product product = productModel(i);
      if (product.id != null &&
          product.title != null &&
          product.description != null &&
          product.price != null &&
          product.avatar != null) products.add(product);
    }
    Category category = Category(
        id: categoryJson["id"],
        name: categoryJson["name"],
        avatar: categoryJson["avatar"],
        products: products);
    return category;
  }
}
