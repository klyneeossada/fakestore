import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../repository/product_repository.dart';

class ProductController {
  final repository = ProductRepository();

ValueNotifier<List<ProductModel>> products =  ValueNotifier<List<ProductModel>> ([]);

  getProducts() async {
    products.value = await repository.getProducts();
  }
}
