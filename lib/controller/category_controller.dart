import 'dart:async';

import 'package:fakestore/models/category_model.dart';
import 'package:fakestore/repository/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CategoryController extends Disposable {
  ValueNotifier<List<CategoryModel>> categories = ValueNotifier<List<CategoryModel>>([]);

  final repository = CategoryRepository();

  getCategory() async {
    categories.value = await repository.getCategories();
  }

  String sortCategories() {
    return categories.value.toString();
  }

  @override
  FutureOr onDispose() {
    categories.dispose();
  }
}
