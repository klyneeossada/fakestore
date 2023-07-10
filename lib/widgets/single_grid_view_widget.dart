import 'package:flutter/material.dart';

import '../controller/cart_controller.dart';
import '../controller/product_controller.dart';
import '../get_it.dart';
import '../models/product_model.dart';

class SingleGridViewWidget extends StatefulWidget {
  const SingleGridViewWidget({super.key});

  @override
  State<SingleGridViewWidget> createState() => _SingleGridViewWidgetState();
}

class _SingleGridViewWidgetState extends State<SingleGridViewWidget> {
  final productController = getIt<ProductController>();
  final cartController = getIt<CartController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<ProductModel>(
        valueListenable: productController.product,
        builder: (_, product, __) {
          return GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
            ),
            children: [
              Card(
                child: Column(
                  children: [
                    Text(product.title),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, 'product-detail-page',
                              arguments: product);
                        },
                        child: Image.network(
                          product.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(
                          () {
                            cartController.cartItems.value.add(product);
                          },
                        );
                      },
                      icon: const Icon(Icons.add),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
