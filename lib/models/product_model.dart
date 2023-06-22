class ProductModel {
  int id;
  String title;
  double price;
  String category;
  String description;
  String image;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      category: json['category'],
      description: json['description'],
      id: json['id'],
      image: json['image'],
      price: json['price'],
      title: json['title'],
    );
  }
}
