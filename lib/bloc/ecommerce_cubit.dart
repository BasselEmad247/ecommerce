import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ecommerce/screens/home.dart';
import 'package:ecommerce/screens/categories.dart';
import 'package:ecommerce/screens/login.dart';
import 'package:ecommerce/screens/menu.dart';
import 'package:ecommerce/bloc/states.dart';

class EcommerceCubit extends Cubit<States> {
  EcommerceCubit() : super(InitialState());

  static EcommerceCubit get(context) => BlocProvider.of(context);

  int index = 0;
  List<Widget> screens = [Home(), Categories(), Login(), Menu()];
  late Database database;

  void changeIndex(int index) {
    this.index = index;
    emit(ChangeScreenIndex());
  }

  void createDB() {}
}
