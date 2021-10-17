import 'dart:developer';

import 'package:ecommerce/bloc/ecommerce_cubit.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/models/user.dart';
import 'package:ecommerce/screens/checkout.dart';
import 'package:ecommerce/screens/product_information.dart';
import 'package:ecommerce/services/http.dart';
import 'package:ecommerce/widgets/cart_widget.dart';
import 'package:flutter/material.dart';

import 'login.dart';

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
          return Column(children: [
            Expanded(
              child: ListView(
                children: List.generate(
                  snapshot.data!.length,
                  (index) {
                    return InkWell(
                        onTap: () {
                          log("Product with id: " +
                              snapshot.data!.elementAt(index).id.toString() +
                              " has been pressed!");

                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return ProductInformation(
                                snapshot.data!.elementAt(index));
                          }));
                        },
                        child: CartWidget(snapshot.data!, index));
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(style: ElevatedButton.styleFrom(
                    side: BorderSide(width: 2.0, color: Colors.grey,),
                    textStyle: const TextStyle(fontSize: 15),
                    onPrimary: Colors.black,
                    primary: Colors.white,
                    minimumSize: Size(150, 50)),onPressed: () async {

                  final response = await http.removeAllProducts(Login.loggedInUser!.token);
                  if(response == 200)
                  {
                    setState(() {
                      EcommerceCubit cubit = EcommerceCubit.get(context);
                      cubit.screens[2] = Cart(Login.loggedInUser);
                      cubit.changeIndex(2);
                    });
                  }
                  else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Failed to remove products from cart!", textAlign: TextAlign.center,)),
                    );
                  }

                }, child: Text("Clear Cart")),
                SizedBox(width: 20,),
                ElevatedButton(style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 15),
                    primary: Colors.red,
                    minimumSize: Size(150, 50)),onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return Checkout();
                      }));
                }, child: Text("Go to Checkout")),
              ],
            )
          ]);
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
