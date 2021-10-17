import 'package:flutter/material.dart';

class Checkout extends StatelessWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Text(
          "Checkout",
          style: TextStyle(fontSize: 35),
        ),
      ),
    );
  }
}
