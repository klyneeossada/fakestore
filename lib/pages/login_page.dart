import 'package:fakestore/controller/user_controller.dart';
import 'package:flutter/material.dart';

import '../widgets/drawer_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = UserController();
  final _formKey = GlobalKey<FormState>();
  final _loginTextController = TextEditingController();
  final _passTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        title: const Row(
          children: [
            Text('Login'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(8.0),
              ),
              height: 200,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _loginTextController,
                            decoration:
                                const InputDecoration(labelText: 'Login'),
                          ),
                          TextFormField(
                            controller: _passTextController,
                            decoration:
                                const InputDecoration(labelText: 'Password'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await userController.login(
                    _loginTextController.text, _passTextController.text);
              },
              child: const Text('Confirm'),
            )
          ],
        ),
      ),
    );
  }
}
