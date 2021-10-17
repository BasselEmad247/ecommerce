import 'dart:developer';

import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/models/user.dart';
import 'package:ecommerce/screens/product_information.dart';
import 'package:ecommerce/services/http.dart';
import 'package:ecommerce/widgets/cart_widget.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  User? user;

  Cart(this.user);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final Http http = Http();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: http.userProducts(widget.user!.token),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.length != 0) {
          return Container(
            child: ListView(
              children: List.generate(
                snapshot.data!.length,
                (index) {
                  return InkWell(
                      onTap: () {
                        log("Product with id: " +
                            snapshot.data!.elementAt(index).id.toString() +
                            " has been pressed!");

                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return ProductInformation(
                              snapshot.data!.elementAt(index));
                        }));
                      },
                      child: CartWidget(snapshot.data!, index));
                },
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data!.length == 0) {
          return Center(
            child: Text(
              "Your cart is empty!",
              style: TextStyle(fontSize: 25, color: Colors.red),
            ),
          );
        }

        return Center(child: const CircularProgressIndicator());
      },
    );
  }
}
