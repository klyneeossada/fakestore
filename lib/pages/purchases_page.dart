import 'package:fakestore/controller/cart_controller.dart';
import 'package:fakestore/get_it.dart';
import 'package:fakestore/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class PurchasesPage extends StatefulWidget {
  const PurchasesPage({super.key});

  @override
  State<PurchasesPage> createState() => _PurchasesPageState();
}

final purchaseController = getIt<CartController>();

class _PurchasesPageState extends State<PurchasesPage> {
  @override
  void initState() {
    super.initState();
    purchaseController.getPurchases();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        title: const Text('Histórico de Compras'),
      ),
      body: ValueListenableBuilder(
        valueListenable: purchaseController.purchases,
        builder: (_, purchases, __) {
          return ListView.builder(
            itemCount: purchaseController.purchases.value.length,
            itemBuilder: (context, index) {
              final cartProducts = purchases[index];
              return Card(
                child: Row(
                  children: [Text(cartProducts.toString())],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
