import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fakestore/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/product_model.dart';
import '../repository/product_repository.dart';

class ProductController extends Disposable {
  final repository = ProductRepository();
  final cartController = CartController();

  ProductController({
    repository,
    cartController,
  });

  final _dio = Dio();

  ValueNotifier<List<ProductModel>> products =
      ValueNotifier<List<ProductModel>>([]);

  getProducts() async {
    products.value = await repository.getProducts();
  }

  Future<int?> addProduct(String title, String price, String description, String image,
      String category) async {
    final response = await _dio.post(
      'https://fakestoreapi.com/products',
      data: {
        'title': title,
        'price': double.tryParse(price),
        'description': description,
        'image': image,
        'category': category
      },
    );
    int? statusCode = response.statusCode;
    return statusCode;
  }

  @override
  FutureOr onDispose() {
    products.dispose();
  }
}
