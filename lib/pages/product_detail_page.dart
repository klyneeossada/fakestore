import 'package:fakestore/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)?.settings.arguments as ProductModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: 300,
            child: Image.network(
              product.image,
              fit: BoxFit.cover,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Editar'),
          )
        ],
      ),
    );
  }
}
