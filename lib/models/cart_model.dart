import 'package:fakestore/models/product_model.dart';

class Cart {
  List<ProductModel> product;
  double total;
  int productQuantity;

  Cart({
    required this.product,
    required this.total,
    required this.productQuantity,
  });
}
