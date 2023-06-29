import 'package:fakestore/controller/product_controller.dart';
import 'package:flutter/material.dart';

class NewProductPage extends StatelessWidget {
  NewProductPage({super.key});

  final _titleTextController = TextEditingController();
  final _priceTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  final _imageTextController = TextEditingController();
  final _categoryTextController = TextEditingController();
  final productController = ProductController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Produto'),
      ),
      body: Column(
        children: [
          Form(
            child: Column(
              children: [
                TextFormField(
                  controller: _titleTextController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextFormField(
                  controller: _priceTextController,
                  decoration: const InputDecoration(labelText: 'Price'),
                ),
                TextFormField(
                  controller: _descriptionTextController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextFormField(
                  controller: _imageTextController,
                  decoration: const InputDecoration(labelText: 'Image'),
                ),
                TextFormField(
                  controller: _categoryTextController,
                  decoration: const InputDecoration(labelText: 'Category'),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () async {
              await productController.addProduct(
                  _titleTextController.text,
                  _priceTextController.text,
                  _descriptionTextController.text,
                  _imageTextController.text,
                  _categoryTextController.text);
            },
            child: const Text('Adicionar'),
          )
        ],
      ),
    );
  }
}
