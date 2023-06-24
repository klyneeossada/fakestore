import 'package:fakestore/controller/cart_controller.dart';
import 'package:flutter/material.dart';

import '../get_it.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final cartController = getIt<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Row(
              children: [
                Text(cartController.cartItems.value.toString()),
              ],
            ),
          );
        },
      ),
    );
  }
}
