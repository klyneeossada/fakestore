import 'package:dio/dio.dart';
import 'package:fakestore/models/category_model.dart';

class CategoryRepository {
  final _dio = Dio();

  Future<List<CategoryModel>> getCategories() async {
    final response =
        await _dio.get('https://fakestoreapi.com/products/categories');
    final categoriesList = (response.data as List<dynamic>).cast<String>();
    return categoriesList.map((category) => CategoryModel(category)).toList();
  }
}
