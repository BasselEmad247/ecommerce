import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/services/http.dart';
import 'package:ecommerce/widgets/products_widget.dart';
import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  final Http http = Http();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: http.fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            color: Colors.grey[400],
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(
                snapshot.data!.length,
                (index) {
                  return ProductsWidget(snapshot.data!, index);
                },
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return Center(child: const CircularProgressIndicator());
      },
    );
  }
}
