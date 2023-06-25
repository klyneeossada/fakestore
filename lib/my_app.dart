import 'package:fakestore/pages/cart_page.dart';
import 'package:fakestore/pages/home_page.dart';
import 'package:fakestore/pages/login_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        '/cart-page': (context) => const CartPage(),
        'login-page': (context) => const LoginPage()
      },
    );
  }
}
