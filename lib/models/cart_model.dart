class CartModel {
  int id;
  List<dynamic> products;
  String date;
  int userID;

  CartModel({
    required this.id,
    required this.products,
    required this.date,
    required this.userID,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      userID: json['userId'],
      date: json['date'],
      id: json['id'],
      products: json['products'],
    );
  }
}
