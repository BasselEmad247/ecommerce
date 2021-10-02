import 'package:ecommerce/widgets/item.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[400],
      child: ListView(
        children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Item("https://thumbs.dreamstime.com/b/phone-icon-black-white-telephone-symbol-vector-illustration-black-handset-icon-white-background-vector-illustration-132728333.jpg", "fdfs", "fds", 123),
            Item("https://thumbs.dreamstime.com/b/phone-icon-black-white-telephone-symbol-vector-illustration-black-handset-icon-white-background-vector-illustration-132728333.jpg", "fdfs", "fds", 123),
          ],
        ),
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Item("https://thumbs.dreamstime.com/b/phone-icon-black-white-telephone-symbol-vector-illustration-black-handset-icon-white-background-vector-illustration-132728333.jpg", "fdfs", "fds", 123),
            Item("https://thumbs.dreamstime.com/b/phone-icon-black-white-telephone-symbol-vector-illustration-black-handset-icon-white-background-vector-illustration-132728333.jpg", "fdfs", "fds", 123),
          ],
        ),
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Item("https://thumbs.dreamstime.com/b/phone-icon-black-white-telephone-symbol-vector-illustration-black-handset-icon-white-background-vector-illustration-132728333.jpg", "fdfs", "fds", 123),
            Item("https://thumbs.dreamstime.com/b/phone-icon-black-white-telephone-symbol-vector-illustration-black-handset-icon-white-background-vector-illustration-132728333.jpg", "fdfs", "fds", 123),
          ],
        ),
        ]
      ),
    );
  }
}
