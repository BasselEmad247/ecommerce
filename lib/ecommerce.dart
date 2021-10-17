import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/bloc/ecommerce_cubit.dart';
import 'package:ecommerce/bloc/states.dart';

class Ecommerce extends StatelessWidget {
  Ecommerce({Key? key}) : super(key: key);

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => EcommerceCubit()..createDB(),
      child: BlocConsumer<EcommerceCubit, States>(
        listener: (context, state) {},
        builder: (context, state) {
          EcommerceCubit cubit = EcommerceCubit.get(context);
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              key: scaffoldKey,
              body: cubit.screens[cubit.index],
              bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.category), label: "Categories"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart), label: "Cart"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: "Menu"),
                ],
                selectedItemColor: Colors.red,
                unselectedItemColor: Colors.grey,
                currentIndex: cubit.index,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
