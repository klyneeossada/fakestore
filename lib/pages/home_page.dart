import 'package:badges/badges.dart' as badges;
import 'package:fakestore/controller/cart_controller.dart';
import 'package:fakestore/controller/home_controller.dart';
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
  final homeController = HomeController();
  bool showAllProducts = true;

  @override
  void initState() {
    super.initState();
    controller.getProducts();
    showAllProducts = true;
  }

  @override
  Widget build(BuildContext context) {
    List<String> dropDownList = [
      'Todos',
      '1',
      '2',
      '3',
      '4',
      '5',
    ];
    String dropDownValue = dropDownList.first;
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
                child: SizedBox(
                  child: Row(
                    children: [
                      const Text('Filtro'),
                      const SizedBox(width: 5),
                      SizedBox(
                        width: 50,
                        child: TextField(
                          onSubmitted: (id) async {
                            if (id.isEmpty || id == '0') {
                              setState(
                                () {
                                  showAllProducts = true;
                                },
                              );
                            } else {
                              await homeController.getSingleProduct(id);
                              setState(
                                () {
                                  showAllProducts = false;
                                },
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: DropdownButton(
                          value: dropDownValue,
                          onChanged: (String? value) {
                            setState(
                              () {
                                dropDownValue = value!;
                              },
                            );
                          },
                          items: dropDownList.map<DropdownMenuItem<String>>(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          showAllProducts
              ? Expanded(
                  child: ValueListenableBuilder<List<ProductModel>>(
                    valueListenable: controller.products,
                    builder: (_, products, __) {
                      if (products.isEmpty) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
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
                                          cartController.cartItems.value
                                              .add(product);
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
                )
              : Expanded(
                  child: ValueListenableBuilder<ProductModel>(
                    valueListenable: homeController.product,
                    builder: (_, product, __) {
                      return GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                                        cartController.cartItems.value
                                            .add(product);
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
