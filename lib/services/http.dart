import 'dart:convert';

import 'package:ecommerce/models/item.dart';
import 'package:http/http.dart' as http;

class Http {
  String allItems = "https://retail.amit-learning.com/api/products/2";

  Future<Item> fetchItems() async {
    final response = await http.get(Uri.parse(allItems));

    if (response.statusCode == 200) {
      return Item.fromJson(jsonDecode(response.body)["product"]);
    } else {
      throw Exception('Failed to load items');
    }
  }
}
