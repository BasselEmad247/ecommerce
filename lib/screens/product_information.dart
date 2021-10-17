import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/services/http.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class ProductInformation extends StatefulWidget {
  Product product;

  ProductInformation(this.product);

  @override
  State<ProductInformation> createState() => _ProductInformationState();
}

class _ProductInformationState extends State<ProductInformation> {
  final Http http = Http();
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        backgroundColor: Colors.red,
      ),
      body: ListView(children: [
        Column(
          children: [
            Image.network(
              widget.product.avatar,
              height: 250,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.product.name,
              style: TextStyle(fontSize: 22),
            ),
            Divider(
              color: Colors.black,
              thickness: 2,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.product.price.toString() +
                      " " +
                      widget.product.currency,
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
                SizedBox(
                  width: 160,
                ),
                InkWell(
                  onTap: () {
                    if (quantity != 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 2, color: Colors.red),
                        color: Colors.red),
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  controller: TextEditingController()
                    ..text = quantity.toString(),
                  showCursor: false,
                  readOnly: true,
                  textAlign: TextAlign.center,
                )),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      quantity++;
                    });
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
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            Divider(
              color: Colors.black,
              thickness: 2,
            ),
            Text(widget.product.description),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                  primary: Colors.red,
                  minimumSize: Size(400, 50)),
              onPressed: () async {
                if (Login.loggedInUser != null) {
                  final response = await http.addProduct(
                      Login.loggedInUser!.token, widget.product.id, quantity);
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
                }
              },
              child: const Text("Add to Cart"),
            ),
          ],
        ),
      ]),
    );
  }
}
