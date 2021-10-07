import 'package:ecommerce/models/item.dart';
import 'package:flutter/material.dart';

class Items extends StatelessWidget {
  List<Item> item;
  int index;

  Items(this.item, this.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Image.network(
              item.elementAt(index).avatar,
              height: 80,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  item.elementAt(index).title.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                )),
            const SizedBox(
              height: 4,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  item.elementAt(index).description,
                  overflow: TextOverflow.ellipsis,
                )),
            Row(
              children: [
                const SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    print("Item with id: " +
                        item.elementAt(index).id.toString() +
                        " has been pressed!");
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
                  width: 70,
                ),
                Text(
                  item.elementAt(index).price.toString() + " EGP",
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
