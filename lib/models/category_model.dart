class CategoryModel {
  final String id = '1';
  final String name;

  CategoryModel(
    this.name,
  );

  @override
  String toString() {
    return name;
  }
}
