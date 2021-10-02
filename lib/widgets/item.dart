import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  String itemImage;
  String itemName;
  String itemDescription;
  int itemPrice;

  Item(this.itemImage, this.itemName, this.itemDescription, this.itemPrice,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      margin: const EdgeInsets.only(top: 10.0),
      width: (width / 2) - 10,
      height: (height / 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            itemImage,
            width: (width / 2) - 10,
            height: (height / 5),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                itemName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              )),
          const SizedBox(
            height: 4,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(itemDescription)),
          Row(
            children: [
              const SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  print("Add button pressed!");
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
                width: 80,
              ),
              Text(
                itemPrice.toString() + " EGP",
                style: const TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}
