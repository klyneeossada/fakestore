import 'package:badges/badges.dart' as badges;
import 'package:fakestore/controller/cart_controller.dart';
import 'package:fakestore/controller/product_controller.dart';
import 'package:flutter/material.dart';

import '../get_it.dart';
import '../models/product_model.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/home_grid_view_builder_widget.dart';
import '../widgets/single_grid_view_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final productController = getIt<ProductController>();
  final cartController = getIt<CartController>();
  bool showAllProducts = true;
  bool showLimitProducts = false;
  bool isSortedAsc = true;

  List<String> limitDropDownList = [
    'Todos',
    '1',
    '2',
    '3',
    '4',
    '5',
  ];
  List<String> sortDropDownList = [
    'asc',
    'desc',
  ];
  String limitDropDownValue = '';
  String sortDropDownValue = '';

  @override
  void initState() {
    super.initState();
    productController.getProducts();
    showAllProducts = true;
    showLimitProducts = false;
    limitDropDownValue = limitDropDownList.first;
    sortDropDownValue = sortDropDownList.first;
    isSortedAsc = true;
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
            ValueListenableBuilder<List<ProductModel>>(
              valueListenable: cartController.cartItems,
              builder: (_, value, __) {
                return badges.Badge(
                  stackFit: StackFit.loose,
                  badgeContent: Text(value.length.toString()),
                  child: IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.popAndPushNamed(context, '/cart-page');
                    },
                  ),
                );
              },
            )
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
                              await productController.getSingleProduct(id);
                              setState(
                                () {
                                  showAllProducts = false;
                                  showLimitProducts = false;
                                },
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 100,
                        child: DropdownButton(
                          value: limitDropDownValue,
                          onChanged: (String? limitId) async {
                            await productController
                                .limitResultProduct(limitId!);
                            if (limitId == 'Todos') {
                              setState(
                                () {
                                  limitDropDownValue = limitId;
                                  showAllProducts = true;
                                },
                              );
                            } else {
                              setState(
                                () {
                                  limitDropDownValue = limitId;
                                  showAllProducts = false;
                                  showLimitProducts = true;
                                },
                              );
                            }
                          },
                          items:
                              limitDropDownList.map<DropdownMenuItem<String>>(
                            (String valueList) {
                              return DropdownMenuItem<String>(
                                value: valueList,
                                child: Text(valueList),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 100,
                        child: DropdownButton(
                          value: sortDropDownValue,
                          onChanged: (String? sort) async {
                            await productController.sortResults(sort!);
                            if (sort == 'asc') {
                              setState(
                                () {
                                  sortDropDownValue = sort;
                                },
                              );
                            } else {
                              setState(
                                () {
                                  sortDropDownValue = sort;
                                },
                              );
                            }
                          },
                          items: sortDropDownList.map<DropdownMenuItem<String>>(
                            (String valueList) {
                              return DropdownMenuItem<String>(
                                value: valueList,
                                child: Text(valueList),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (showAllProducts)
            const HomeGridViewWidget()
          else if (showLimitProducts)
            const HomeGridViewWidget()
          else
            const SingleGridViewWidget()
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
