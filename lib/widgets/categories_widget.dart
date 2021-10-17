import 'dart:developer';

import 'package:ecommerce/models/category.dart';
import 'package:flutter/material.dart';

import 'category_widget.dart';

class CategoriesWidget extends StatelessWidget {
  List<Category> category;
  int index;

  CategoriesWidget(this.category, this.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(children: [
        InkWell(
          onTap: () {
            log("Category with id: " +
                category.elementAt(index).id.toString() +
                " has been pressed!");

            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return CategoryWidget(
                  category.elementAt(index).id, category.elementAt(index).name);
            }));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
              image: DecorationImage(
                image: NetworkImage(category.elementAt(index).avatar),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Container(
                  child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.6), BlendMode.dstATop),
                      child: Text(
                        category.elementAt(index).name.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white),
                      ))),
            ),
          ),
        ),
      ]),
    );
  }
}
