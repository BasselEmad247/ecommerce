import 'dart:developer';

import 'package:ecommerce/bloc/ecommerce_cubit.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/screens/login.dart';
import 'package:ecommerce/services/http.dart';
import 'package:flutter/material.dart';

class ProductsWidget extends StatefulWidget {
  List<Product> product;
  int index;

  ProductsWidget(this.product, this.index);

  @override
  State<ProductsWidget> createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {
  final Http http = Http();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Image.network(
              widget.product.elementAt(widget.index).avatar,
              height: 80,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  widget.product.elementAt(widget.index).name.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                )),
            const SizedBox(
              height: 4,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  widget.product.elementAt(widget.index).description,
                  overflow: TextOverflow.ellipsis,
                )),
            Row(
              children: [
                const SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () async {
                    log("Product with id: " +
                        widget.product.elementAt(widget.index).id.toString() +
                        " has been pressed!");

                    EcommerceCubit cubit = EcommerceCubit.get(context);

                    if (Login.loggedInUser != null) {
                      final response = await http.addProduct(
                          Login.loggedInUser!.token,
                          widget.product.elementAt(widget.index).id,
                          1);
                      if (response == 200) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                            "Product added to your cart successfully!",
                            textAlign: TextAlign.center,
                          )),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                            "Error!",
                            textAlign: TextAlign.center,
                          )),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                          "Please login first!",
                          textAlign: TextAlign.center,
                        )),
                      );
                      cubit.changeIndex(2);
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 2, color: Colors.red),
                        color: Colors.red),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 70,
                ),
                Text(
                  widget.product.elementAt(widget.index).price.toString() +
                      " " +
                      widget.product.elementAt(widget.index).currency,
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
