import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:ecommerce/bloc/ecommerce_bloc_observer.dart';
import 'package:ecommerce/ecommerce.dart';

void main() {
  Bloc.observer = EcommerceBlocObserver();

  runApp(MaterialApp(
    title: "ecommerce",
    home: Ecommerce(),
    debugShowCheckedModeBanner: false,
  ));
}
