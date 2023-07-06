import 'package:badges/badges.dart' as badges;
import 'package:fakestore/controller/cart_controller.dart';
import 'package:fakestore/controller/product_controller.dart';
import 'package:flutter/material.dart';

import '../get_it.dart';
import '../models/product_model.dart';
import '../widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = getIt<ProductController>();
  final cartController = getIt<CartController>();

  @override
  void initState() {
    super.initState();
    controller.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeDrawer(),
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
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/cart-page');
                },
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                height: 50,
                width: 500,
                child: const SizedBox(
                  child: Row(children: [
                    Text('Filtro'),
                    SizedBox(width: 5),
                    SizedBox(
                      width: 50,
                      child: TextField(),
                    )
                  ]),
                ),
              ),
            ],
          ),
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
                                Navigator.pushNamed(
                                    context, 'product-detail-page',
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
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'addproduct-page');
        },
      ),
    );
  }
}
