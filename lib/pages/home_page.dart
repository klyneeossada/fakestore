import 'package:badges/badges.dart' as badges;
import 'package:fakestore/controller/cart_controller.dart';
import 'package:fakestore/controller/product_controller.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = ProductController();
  final cartController = CartController();

  @override
  void initState() {
    super.initState();
    controller.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('FakeStore'),
            badges.Badge(
              stackFit: StackFit.loose,
              badgeContent:
                  Text(cartController.cartItems.value.length.toString()),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<List<ProductModel>>(
              valueListenable: controller.products,
              builder: (_, products, __) {
                if (products.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
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
                                setState(() {
                                  cartController.cartItems.value.add(product);
                                });
                              },
                              child: Image.network(
                                product.image,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
