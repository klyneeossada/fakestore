import 'dart:math';

class CategoryModel {
  final int id = Random().nextInt(50);
  final String name;

  CategoryModel(
    this.name,
  );

  @override
  String toString() {
    return name;
  }
}
