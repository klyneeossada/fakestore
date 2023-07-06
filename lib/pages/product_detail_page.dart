import 'package:fakestore/models/product_model.dart';
import 'package:flutter/material.dart';

import '../controller/product_controller.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = ProductController();
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
            onPressed: () {
              Navigator.pushNamed(context, 'edit-product-page',
                  arguments: product);
            },
            child: const Text('Editar'),
          ),
          TextButton(
            onPressed: () async {
              final statusCode = await productController.deleteProduct(
                  product.id,
                  product.title,
                  product.price.toString(),
                  product.description,
                  product.image,
                  product.category);

              if (statusCode == 200) {
                const snackBar = SnackBar(
                  content: Text('Produto deletado com sucesso!'),
                  duration: Duration(seconds: 2),
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }
            },
            child: const Text(
              'Deletar',
              style: TextStyle(color: Colors.red),
            ),
          )
        ],
      ),
    );
  }
}
