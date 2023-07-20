import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fakestore/repository/purchase_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../models/cart_model.dart';
import '../models/product_model.dart';

class CartController extends Disposable {
  ValueNotifier<List<ProductModel>> cartItems =
      ValueNotifier<List<ProductModel>>([]);

  ValueNotifier<List<CartModel>> purchases = ValueNotifier<List<CartModel>>([]);
  late ValueNotifier<CartModel> purchase;

  final repository = PurchasesRepository();

  final _dio = Dio();

  addToCart(ProductModel product) {
    cartItems.value.add(product);
    cartItems.value = List.from(cartItems.value);
  }

  @override
  FutureOr onDispose() {
    cartItems.dispose();
  }

  getPurchases() async {
    purchases.value = await repository.getPurchases();
  }

  getSinglePurchase(String id) async {
    final response = await _dio.get('https://fakestoreapi.com/carts/$id');
    final purchaseData = (response.data as Map<String, dynamic>);
    final purchaseModel = CartModel.fromJson(purchaseData);
    purchase = ValueNotifier<CartModel>(purchaseModel);
  }

  limitResultPurchase(String number) async {
    final response =
        await _dio.get('https://fakestoreapi.com/carts?limit=$number');
    final limitedPurchases = (response.data as List);
    final result = limitedPurchases.map((e) => CartModel.fromJson(e)).toList();
    purchases.value = result;
  }

    sortResults(String results) async {
    final response =
        await _dio.get('https://fakestoreapi.com/carts?sort=$results');
    final sortedProducts = (response.data as List);
    final result = sortedProducts.map((e) => CartModel.fromJson(e)).toList();
    purchases.value = result;
  }
}
