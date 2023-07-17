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

  late ValueNotifier<ProductModel> product;

  getProducts() async {
    products.value = await repository.getProducts();
  }

  Future<int?> addProduct(String title, String price, String description,
      String image, String category) async {
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

  Future<int?> updateProduct(int id, String title, String price,
      String description, String image, String category) async {
    final url = 'https://fakestoreapi.com/products/$id';
    final response = await _dio.patch(
      url,
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

  Future<int?> deleteProduct(int id, String title, String price,
      String description, String image, String category) async {
    final url = 'https://fakestoreapi.com/products/$id';
    final response = await _dio.delete(
      url,
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

  getSingleProduct(String id) async {
    final response = await _dio.get('https://fakestoreapi.com/products/$id');
    final productData = (response.data as Map<String, dynamic>);
    final productModel = ProductModel.fromJson(productData);
    product = ValueNotifier<ProductModel>(productModel);
  }

  limitResultProduct(String number) async {
    final response =
        await _dio.get('https://fakestoreapi.com/products?limit=$number');
    final limitedProducts = (response.data as List);
    final result =
        limitedProducts.map((e) => ProductModel.fromJson(e)).toList();
    products.value = result;
  }

  sortResults(String results) async {
    final response =
        await _dio.get('https://fakestoreapi.com/products?sort=$results');
    final sortedProducts = (response.data as List);
    final result = sortedProducts.map((e) => ProductModel.fromJson(e)).toList();
    products.value = result;
  }
}
