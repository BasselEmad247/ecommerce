import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';

class ProductsWidget extends StatelessWidget {
  List<Product> product;
  int index;

  ProductsWidget(this.product, this.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Image.network(
              product.elementAt(index).avatar,
              height: 80,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  product.elementAt(index).title.toString().replaceAll("  ", ""),
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
                  product.elementAt(index).description.replaceAll("  ", ""),
                  overflow: TextOverflow.ellipsis,
                )),
            Row(
              children: [
                const SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    print("Product with id: " +
                        product.elementAt(index).id.toString() +
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
                  product.elementAt(index).price.toString() + " EGP",
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
