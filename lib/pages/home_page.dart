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

  @override
  void initState() {
    super.initState();
    controller.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FakeStore'),
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Card(
                        child: Column(
                          children: [
                            Text(product.title),
                            Image.network(product.image),
                          ],
                        ),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
