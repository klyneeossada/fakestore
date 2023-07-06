import 'package:flutter/material.dart';

import '../controller/product_controller.dart';
import '../models/product_model.dart';
import '../widgets/drawer.dart';

class EditProductPage extends StatelessWidget {
  const EditProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)?.settings.arguments as ProductModel;
    final productController = ProductController();
    final titleTextController = TextEditingController(text: product.title);
    final priceTextController =
        TextEditingController(text: product.price.toString());
    final descriptionTextController =
        TextEditingController(text: product.description);
    final imageTextController = TextEditingController(text: product.image);
    final categoryTextController =
        TextEditingController(text: product.category);

    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        title: const Row(
          children: [
            Text('Adicionar produto'),
          ],
        ),
      ),
      body: Column(
        children: [
          Form(
            child: Column(
              children: [
                TextFormField(
                  initialValue: product.title,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextFormField(
                  controller: priceTextController,
                  decoration: const InputDecoration(labelText: 'Price'),
                ),
                TextFormField(
                  controller: descriptionTextController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextFormField(
                  controller: imageTextController,
                  decoration: const InputDecoration(labelText: 'Image'),
                ),
                TextFormField(
                  controller: categoryTextController,
                  decoration: const InputDecoration(labelText: 'Category'),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () async {
              final statusCode = await productController.updateProduct(
                  product.id,
                  titleTextController.text,
                  priceTextController.text,
                  descriptionTextController.text,
                  imageTextController.text,
                  categoryTextController.text);

              if (statusCode == 200) {
                const snackBar = SnackBar(
                  content: Text('Produto atualizado com sucesso!'),
                  duration: Duration(seconds: 2),
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }
            },
            child: const Text('Editar'),
          ),
        ],
      ),
    );
  }
}
