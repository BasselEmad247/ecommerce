import 'package:ecommerce/services/http.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final Http http = Http();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset("images/logo.jpg"),
    );
  }
}
