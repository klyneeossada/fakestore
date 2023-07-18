import 'dart:async';

import 'package:fakestore/repository/purchase_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../models/product_model.dart';

class CartController extends Disposable {
  ValueNotifier<List<ProductModel>> cartItems =
      ValueNotifier<List<ProductModel>>([]);

  ValueNotifier<List> purchases = ValueNotifier<List>([]);

  final repository = PurchasesRepository();

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
}
