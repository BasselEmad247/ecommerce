import 'package:ecommerce/bloc/ecommerce_cubit.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/screens/cart.dart';
import 'package:ecommerce/screens/login.dart';
import 'package:ecommerce/services/http.dart';
import 'package:flutter/material.dart';

class CartWidget extends StatefulWidget {
  List<Product> product;
  int index;

  CartWidget(this.product, this.index);

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final Http http = Http();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Image.network(
                widget.product[widget.index].avatar,
                height: 100,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      widget.product[widget.index].name,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(widget.product[widget.index].description,
                        overflow: TextOverflow.ellipsis),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          widget.product[widget.index].price.toString() +
                              " " +
                              widget.product[widget.index].currency,
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        InkWell(
                          onTap: () async {

                            final response = await http.addProduct(Login.loggedInUser!.token, widget.product[widget.index].id, -1);
                            if(response == 200)
                            {
                              setState(() {
                                widget.product[widget.index].userAmount -= 1;
                                EcommerceCubit cubit = EcommerceCubit.get(context);
                                cubit.screens[2] = Cart(Login.loggedInUser);
                                cubit.changeIndex(2);
                              });
                            }
                            else
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Failed to remove product from cart!", textAlign: TextAlign.center,)),
                              );
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(width: 2, color: Colors.red),
                                color: Colors.red),
                            child: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                            child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          controller: TextEditingController()
                            ..text = widget.product[widget.index].userAmount.toString(),
                          showCursor: false,
                          readOnly: true,
                          textAlign: TextAlign.center,
                        )),
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () async {

                            final response = await http.addProduct(Login.loggedInUser!.token, widget.product[widget.index].id, 1);
                            if(response == 200)
                              {
                                setState(() {
                                  widget.product[widget.index].userAmount += 1;
                                });
                              }
                            else
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Failed to add product to cart!", textAlign: TextAlign.center,)),
                                );
                              }
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
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey,
            thickness: 0.5,
          )
        ],
      ),
    );
  }
}
