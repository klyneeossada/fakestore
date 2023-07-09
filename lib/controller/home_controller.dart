import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../models/product_model.dart';

class HomeController {
  final _dio = Dio();

  late ValueNotifier<ProductModel> product;

  getSingleProduct(String id) async {
    final response = await _dio.get('https://fakestoreapi.com/products/$id');
    final productData = (response.data as Map<String, dynamic>);
    final productModel = ProductModel.fromJson(productData);
    product = ValueNotifier<ProductModel>(productModel);
  }

  Future<List<ProductModel>> limitResultProduct(String number) async {
    final response =
        await _dio.get('https://fakestoreapi.com/products?limit=$number');
    final products = (response.data as List);
    final result = products.map((e) => ProductModel.fromJson(e)).toList();

    return result;
  }
}
