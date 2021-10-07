import 'package:ecommerce/models/item.dart';
import 'package:ecommerce/services/http.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final Http http = Http();
  late Future<Item> futureItems = http.fetchItems();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Item>(
      future: futureItems,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.title);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );

    // return Container(
    //   color: Colors.grey[400],
    //   child: ListView(
    //     children: [
    //       Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       children: [
    //         Item("https://thumbs.dreamstime.com/b/phone-icon-black-white-telephone-symbol-vector-illustration-black-handset-icon-white-background-vector-illustration-132728333.jpg", "fdfs", "fds", 123),
    //         Item("https://thumbs.dreamstime.com/b/phone-icon-black-white-telephone-symbol-vector-illustration-black-handset-icon-white-background-vector-illustration-132728333.jpg", "fdfs", "fds", 123),
    //       ],
    //     ),
    //       Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       children: [
    //         Item("https://thumbs.dreamstime.com/b/phone-icon-black-white-telephone-symbol-vector-illustration-black-handset-icon-white-background-vector-illustration-132728333.jpg", "fdfs", "fds", 123),
    //         Item("https://thumbs.dreamstime.com/b/phone-icon-black-white-telephone-symbol-vector-illustration-black-handset-icon-white-background-vector-illustration-132728333.jpg", "fdfs", "fds", 123),
    //       ],
    //     ),
    //       Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       children: [
    //         Item("https://thumbs.dreamstime.com/b/phone-icon-black-white-telephone-symbol-vector-illustration-black-handset-icon-white-background-vector-illustration-132728333.jpg", "fdfs", "fds", 123),
    //         Item("https://thumbs.dreamstime.com/b/phone-icon-black-white-telephone-symbol-vector-illustration-black-handset-icon-white-background-vector-illustration-132728333.jpg", "fdfs", "fds", 123),
    //       ],
    //     ),
    //     ]
    //   ),
    // );
  }
}
