import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/product_model.dart';
import '../repository/product_repository.dart';

class ProductController extends Disposable {
  final repository = ProductRepository();

  ValueNotifier<List<ProductModel>> products =
      ValueNotifier<List<ProductModel>>([]);

  getProducts() async {
    products.value = await repository.getProducts();
  }

  @override
  FutureOr onDispose() {
    products.dispose();
  }
}
