import "dart:convert";

import "package:ecommerce/models/category.dart";
import "package:ecommerce/models/product.dart";
import "package:ecommerce/models/user.dart";
import "package:http/http.dart" as http;

class Http {
  String allProducts = "https://retail.amit-learning.com/api/products";
  String allCategories = "https://retail.amit-learning.com/api/categories";
  String category = "https://retail.amit-learning.com/api/categories/";
  String userLogin = "https://retail.amit-learning.com/api/login";
  String userRegister = "https://retail.amit-learning.com/api/register";
  String getUser = "https://retail.amit-learning.com/api/user";
  String getUserProducts = "https://retail.amit-learning.com/api/user/products";
  String addProductToUser =
      "https://retail.amit-learning.com/api/user/products/";

  Future<int> loginStatus(String email, String password) async {
    final response = await http.post(Uri.parse(userLogin),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "email": email,
          "password": password,
        }));

    return response.statusCode;
  }

  Future<String> loginToken(String email, String password) async {
    final response = await http.post(Uri.parse(userLogin),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "email": email,
          "password": password,
        }));

    String token = jsonDecode(response.body)["token"];

    return token;
  }

  Future<int> register(String name, String email, String password) async {
    final response = await http.post(Uri.parse(userRegister),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "name": name,
          "email": email,
          "password": password,
        }));

    return response.statusCode;
  }

  Future<User> getUserDetails(String token) async {
    final response = await http.get(Uri.parse(getUser), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + token
    });

    if (response.statusCode == 200) {
      dynamic userJson = jsonDecode(response.body)["user"];

      User user = userModel(userJson, token);

      return user;
    } else {
      throw Exception("Failed to get user's details");
    }
  }

  Future<List<Product>> userProducts(String token) async {
    final response = await http.get(Uri.parse(getUserProducts), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + token
    });

    if (response.statusCode == 200) {
      dynamic productsJson = jsonDecode(response.body)["products"];

      List<Product> products = productsCartModel(productsJson);

      return products;
    } else {
      throw Exception("Failed to get user's products");
    }
  }

  Future<int> addProduct(String token, int productId, int amount) async {
    int oldAmount = 0;
    List<Product> oldUserProducts = await userProducts(token);
    for (int i = 0; i < oldUserProducts.length; i++) {
      if (oldUserProducts[i].id == productId) {
        oldAmount = oldUserProducts[i].userAmount;
        break;
      }
    }
    amount += oldAmount;
    final response = await http.put(
        Uri.parse(addProductToUser + productId.toString()),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + token
        },
        body: jsonEncode(<String, int>{
          "amount": amount,
        }));

    return response.statusCode;
  }

  Future<int> removeAllProducts(String token) async {
    List<Product> oldUserProducts = await userProducts(token);
    dynamic lastResponse;

    for (int i = 0; i < oldUserProducts.length; i++) {
      final response = await http.put(
          Uri.parse(addProductToUser + oldUserProducts[i].id.toString()),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token
          },
          body: jsonEncode(<String, int>{
            "amount": 0,
          }));
      lastResponse = response;
    }

    return lastResponse.statusCode;
  }

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(allProducts));

    if (response.statusCode == 200) {
      List<dynamic> productsJson = jsonDecode(response.body)["products"];

      List<Product> products = productsModel(productsJson);

      return products;
    } else {
      throw Exception("Failed to load products");
    }
  }

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse(allCategories));

    if (response.statusCode == 200) {
      List<dynamic> categoriesJson = jsonDecode(response.body)["categories"];

      List<Category> categories = categoriesModel(categoriesJson);

      return categories;
    } else {
      throw Exception("Failed to load categories");
    }
  }

  Future<Product> fetchProduct(int productId) async {
    final response =
        await http.get(Uri.parse(allProducts + productId.toString()));

    if (response.statusCode == 200) {
      dynamic productJson = jsonDecode(response.body)["product"];

      Product product = productModel(productJson);

      return product;
    } else {
      throw Exception("Failed to load product");
    }
  }

  Future<List<Product>> fetchCategory(int categoryId) async {
    final response =
        await http.get(Uri.parse(category + categoryId.toString()));

    if (response.statusCode == 200) {
      dynamic categoryJson = jsonDecode(response.body)["category"];

      Category category = categoryModel(categoryJson);

      return category.products!;
    } else {
      throw Exception("Failed to load category");
    }
  }

  List<Product> productsModel(List<dynamic> productsJson) {
    List<Product> products = [];

    for (dynamic i in productsJson) {
      if (i["id"] == null || i["price"] == null || i["avatar"] == null) {
        continue;
      }
      String description = " ";
      if (i["description"] != null) {
        description = i["description"];
      }
      Product product = Product(
          id: i["id"],
          name: i["name"],
          title: i["title"],
          category_id: i["category_id"],
          description: description,
          price: i["price"],
          discount: i["discount"],
          discount_type: i["discount_type"],
          currency: i["currency"],
          in_stock: i["in_stock"],
          avatar: i["avatar"],
          price_final: i["price_final"],
          price_final_text: i["price_final_text"],
          userAmount: i["userAmount"]);

      products.add(product);
    }
    return products;
  }

  List<Product> productsCartModel(List<dynamic> productsJson) {
    List<Product> products = [];

    for (dynamic i in productsJson) {
      if (i["product"]["id"] == null ||
          i["product"]["price"] == null ||
          i["product"]["avatar"] == null) {
        continue;
      }
      String description = " ";
      if (i["product"]["description"] != null) {
        description = i["product"]["description"];
      }
      Product product = Product(
          id: i["product"]["id"],
          name: i["product"]["name"],
          title: i["product"]["title"],
          category_id: i["product"]["category_id"],
          description: description,
          price: i["product"]["price"],
          discount: i["product"]["discount"],
          discount_type: i["product"]["discount_type"],
          currency: i["product"]["currency"],
          in_stock: i["product"]["in_stock"],
          avatar: i["product"]["avatar"],
          price_final: i["product"]["price_final"],
          price_final_text: i["product"]["price_final_text"],
          userAmount: i["amount"]);

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
          product.price != null &&
          product.avatar != null) {
        if (product.description == null) {
          product.description = " ";
        }
        products.add(product);
      }
    }
    Category category = Category(
        id: categoryJson["id"],
        name: categoryJson["name"],
        avatar: categoryJson["avatar"],
        products: products);
    return category;
  }

  User userModel(dynamic userJson, dynamic token) {
    User user = User(
      id: userJson["id"],
      name: userJson["name"],
      email: userJson["email"],
      token: token,
    );

    return user;
  }
}
