import 'package:dio/dio.dart';

import 'package:fakestore/models/product_model.dart';

class ProductRepository {
  final _dio = Dio();

  Future<List<ProductModel>> getProducts() async {
    final response = await _dio.get('https://fakestoreapi.com/products');
    final products = (response.data as List);

    final result = products.map((e) => ProductModel.fromJson(e)).toList();

    return result;
  }
}
