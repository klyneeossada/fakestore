import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fakestore/controller/product_controller.dart';
import 'package:fakestore/models/category_model.dart';
import 'package:fakestore/models/product_model.dart';
import 'package:fakestore/repository/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../get_it.dart';

class CategoryController extends Disposable {
  ValueNotifier<List<CategoryModel>> categories =
      ValueNotifier<List<CategoryModel>>([]);

  final productController = getIt<ProductController>();

  final categoryRepository = CategoryRepository();

  final _dio = Dio();

  getCategory() async {
    final result = await categoryRepository.getCategories();
    final uniqueCategories = <CategoryModel>{
      CategoryModel('Todos'),
      ...result.map((e) => CategoryModel(e.toString()))
    };

    categories.value = uniqueCategories.toList();
  }

  sortCategories(CategoryModel categoryModel) async {
    final category = categoryModel.name;
    final response =
        await _dio.get('https://fakestoreapi.com/products/category/$category');

    final sortedCategory = (response.data as List);
    final result = sortedCategory.map((e) => ProductModel.fromJson(e)).toList();
    productController.products.value = result;
  }

  @override
  FutureOr onDispose() {
    categories.dispose();
  }
}
