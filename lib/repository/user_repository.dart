import 'package:dio/dio.dart';
import 'package:fakestore/models/user_model.dart';

class UserRepository {
  final _dio = Dio();

  Future<List<UserModel>> getUsers() async {
    final response = await _dio.get('https://fakestoreapi.com/users');
    final user = (response.data as List);

    final result = user.map((e) => UserModel.fromJson(e)).toList();

    return result;
  }

  Future<String> login(String login, String pass) async {
    final response = await _dio.post(
      'https://fakestoreapi.com/auth/login',
      data: {
        'username': login,
        'password': pass,
      },
    );
    final result = LoginModel.fromJson(response.data);
    return result.token.toString();
  }
}
