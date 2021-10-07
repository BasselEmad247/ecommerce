import 'dart:convert';

import 'package:ecommerce/models/category.dart';
import 'package:ecommerce/models/item.dart';
import 'package:http/http.dart' as http;

class Http {
  String allItems = "https://retail.amit-learning.com/api/products/";
  String allCategories = "https://retail.amit-learning.com/api/categories/";

  Future<List<Item>> fetchItems() async {
    final response = await http.get(Uri.parse(allItems));

    if (response.statusCode == 200) {
      List<dynamic> itemsJson = jsonDecode(response.body)["products"];

      List<Item> items = itemsModel(itemsJson);

      return items;
    } else {
      throw Exception('Failed to load items');
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

  Future<Item> fetchItem(int id) async {
    final response = await http.get(Uri.parse(allItems + id.toString()));

    if (response.statusCode == 200) {
      dynamic itemJson = jsonDecode(response.body)["product"];

      Item item = itemModel(itemJson);

      return item;
    } else {
      throw Exception('Failed to load item');
    }
  }

  Future<Category> fetchCategory(int id) async {
    final response = await http.get(Uri.parse(allCategories + id.toString()));

    if (response.statusCode == 200) {
      dynamic categoryJson = jsonDecode(response.body)["category"];

      Category category = categoryModel(categoryJson);

      return category;
    } else {
      throw Exception('Failed to load category');
    }
  }

  List<Item> itemsModel(List<dynamic> itemsJson) {
    List<Item> items = [];

    for (dynamic i in itemsJson) {
      if (i["id"] == null ||
          i["title"] == null ||
          i["description"] == null ||
          i["price"] == null ||
          i["avatar"] == null) {
        continue;
      }
      Item item = Item(
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

      items.add(item);
    }
    return items;
  }

  List<Category> categoriesModel(List<dynamic> categoriesJson) {
    List<Category> categories = [];

    for (dynamic i in categoriesJson) {
      if (i["id"] == null || i["name"] == null || i["avatar"] == null) {
        continue;
      }
      Category category =
          Category(id: i["id"], name: i["name"], avatar: i["avatar"]);

      categories.add(category);
    }
    return categories;
  }

  Item itemModel(dynamic itemJson) {
    Item item = Item(
        id: itemJson["id"],
        name: itemJson["name"],
        title: itemJson["title"],
        category_id: itemJson["category_id"],
        description: itemJson["description"],
        price: itemJson["price"],
        discount: itemJson["discount"],
        discount_type: itemJson["discount_type"],
        currency: itemJson["currency"],
        in_stock: itemJson["in_stock"],
        avatar: itemJson["avatar"],
        price_final: itemJson["price_final"],
        price_final_text: itemJson["price_final_text"]);

    return item;
  }

  Category categoryModel(dynamic categoryJson) {
    Category category = Category(
        id: categoryJson["id"],
        name: categoryJson["name"],
        avatar: categoryJson["avatar"]);
    return category;
  }
}
