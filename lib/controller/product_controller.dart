import 'dart:async';

import 'package:fakestore/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/product_model.dart';
import '../repository/product_repository.dart';

class ProductController extends Disposable {
  final repository = ProductRepository();
  final cartController = CartController();

  ProductController({
    required repository,
    required cartController,
  });

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
