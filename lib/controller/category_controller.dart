import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CategoryController extends Disposable {
  ValueNotifier<List> categories = ValueNotifier<List>([]);

  final _dio = Dio();

  getCategories() async {
    final response =
        await _dio.get('https://fakestoreapi.com/products/categories');
    final categoriesList = (response.data as List);

    categories.value = categoriesList;
  }

  String sortCategories() {
    return categories.value.toString();
  }

  @override
  FutureOr onDispose() {
    categories.dispose();
  }
}
