import 'dart:async';

import 'package:fakestore/repository/user_repository.dart';
import 'package:get_it/get_it.dart';

class UserController extends Disposable {
  Future<void> login(String login, String password) async {
    final userRepository = UserRepository();
    await userRepository.login(login, password);
  }

  @override
  FutureOr onDispose() {}
}
