import 'package:dio/dio.dart';
import 'package:fakestore/models/cart_model.dart';

class PurchasesRepository {
  final _dio = Dio();

  getPurchases() async {
    final response = await _dio.get('https://fakestoreapi.com/carts');
    final purchases = (response.data as List);
    final result = purchases.map((e) => CartModel.fromJson(e)).toList();
    return result;
  }
}
