import 'dart:js_interop';

import 'package:flutter/material.dart';

import '../controller/category_controller.dart';
import '../controller/product_controller.dart';
import '../get_it.dart';
import '../models/category_model.dart';

class CategoryDropDown extends StatefulWidget {
  const CategoryDropDown({super.key});

  @override
  State<CategoryDropDown> createState() => _CategoryDropDownState();
}

class _CategoryDropDownState extends State<CategoryDropDown> {
  final categoryController = getIt<CategoryController>();
  final productController = getIt<ProductController>();
  CategoryModel? selectedCategory;

  @override
  void initState() {
    super.initState();
    categoryController.getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: categoryController.categories,
      builder: (_, categories, __) {
        if (categories.isEmpty) {
          return const SizedBox.shrink();
        }
        return SizedBox(
          width: 150,
          child: DropdownButton(
            value: selectedCategory.isNull ? categories[0] : selectedCategory,
            onChanged: (CategoryModel? category) {
              if (category == categories[0]) {
                productController.getProducts();
              } else {
                categoryController.sortCategories(category!);
              }
              setState(() {
                selectedCategory = category;
              });
            },
            items: categories.map<DropdownMenuItem<CategoryModel>>(
              (element) {
                return DropdownMenuItem(
                  value: element,
                  child: Text(element.name),
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }
}
