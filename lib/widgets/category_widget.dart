import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/screens/product_information.dart';
import 'package:ecommerce/services/http.dart';
import 'package:ecommerce/widgets/products_widget.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final Http http = Http();
  int categoryId;
  String categoryName;

  CategoryWidget(this.categoryId, this.categoryName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder<List<Product>>(
        future: http.fetchCategory(categoryId),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.length != 0) {
            return Container(
              color: Colors.grey[400],
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(
                  snapshot.data!.length,
                  (index) {
                    return InkWell(
                        onTap: () {
                          print("Product with id: " +
                              snapshot.data!.elementAt(index).id.toString() +
                              " has been pressed!");

                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return ProductInformation(
                                snapshot.data!.elementAt(index));
                          }));
                        },
                        child: ProductsWidget(snapshot.data!, index));
                  },
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else if (snapshot.hasData && snapshot.data!.length == 0) {
            return Center(
              child: Text(
                "No products found!",
                style: TextStyle(fontSize: 25, color: Colors.red),
              ),
            );
          }

          return Center(child: const CircularProgressIndicator());
        },
      ),
    );
  }
}
