import 'package:flutter/material.dart';

import '../controller/cart_controller.dart';
import '../controller/product_controller.dart';
import '../get_it.dart';
import '../models/product_model.dart';

class HomeGridViewWidget extends StatefulWidget {
  const HomeGridViewWidget({super.key});

  @override
  State<HomeGridViewWidget> createState() => _HomeGridViewState();
}

class _HomeGridViewState extends State<HomeGridViewWidget> {
  final productController = getIt<ProductController>();
  final cartController = getIt<CartController>();


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<List<ProductModel>>(
        valueListenable: productController.products,
        builder: (_, products, __) {
          if (products.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
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
                );
              },
            );
          }
        },
      ),
    );
  }
}
