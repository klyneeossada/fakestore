import 'package:fakestore/repository/product_repository.dart';
import 'package:get_it/get_it.dart';

import 'controller/cart_controller.dart';
import 'controller/product_controller.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<ProductRepository>(ProductRepository());
  getIt.registerSingleton<CartController>(CartController());
  getIt.registerSingleton<ProductController>(ProductController());
}
