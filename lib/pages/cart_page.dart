import 'package:fakestore/controller/cart_controller.dart';
import 'package:flutter/material.dart';

import '../get_it.dart';
import '../models/product_model.dart';
import '../widgets/drawer_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var cartController = getIt<CartController>();
  late List<ProductModel> cartProducts;

  @override
  void initState() {
    super.initState();
    cartProducts = cartController.cartItems.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Carrinho'),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'purchases-page');
              },
              icon: const Icon(Icons.wallet),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: cartController.cartItems.value.length,
        itemBuilder: (context, index) {
          final cartProduct = cartProducts[index];
          return Card(
            child: Row(
              children: [
                Text(cartProduct.title),
              ],
            ),
          );
        },
      ),
    );
  }
}
