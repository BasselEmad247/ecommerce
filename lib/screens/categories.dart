import 'package:ecommerce/models/category.dart';
import 'package:ecommerce/services/http.dart';
import 'package:ecommerce/widgets/categories_widget.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  final Http http = Http();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: http.fetchCategories(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            color: Colors.grey[400],
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(
                snapshot.data!.length,
                    (index) {
                  return CategoriesWidget(snapshot.data!, index);
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
