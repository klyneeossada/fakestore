import 'package:fakestore/repository/user_repository.dart';

Future<void> main() async {
  final repository = UserRepository();
  final users = await repository.getUsers();

  print(users);
}
