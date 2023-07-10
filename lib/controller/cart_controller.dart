import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../models/product_model.dart';

class CartController extends Disposable {
  ValueNotifier<List<ProductModel>> cartItems =
      ValueNotifier<List<ProductModel>>([]);

  

  @override
  FutureOr onDispose() {
    cartItems.dispose();
  }
}
