import 'dart:convert';

import 'package:ecommerce/models/item.dart';
import 'package:http/http.dart' as http;

class Http {
  String allItems = "https://retail.amit-learning.com/api/products";

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
}
