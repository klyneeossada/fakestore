import 'package:fakestore/controller/cart_controller.dart';
import 'package:fakestore/get_it.dart';
import 'package:fakestore/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PurchasesPage extends StatefulWidget {
  const PurchasesPage({super.key});

  @override
  State<PurchasesPage> createState() => _PurchasesPageState();
}

final purchaseController = getIt<CartController>();
bool showAllPurchase = true;

TextEditingController initialDate = TextEditingController();
TextEditingController finalDate = TextEditingController();

List<String> limitDropDownList = [
  'Todos',
  '1',
  '2',
  '3',
  '4',
  '5',
];
List<String> sortDropDownList = [
  'asc',
  'desc',
];
String limitDropDownValue = '';
String sortDropDownValue = '';

class _PurchasesPageState extends State<PurchasesPage> {
  @override
  void initState() {
    super.initState();
    purchaseController.getPurchases();
    limitDropDownValue = limitDropDownList.first;
    sortDropDownValue = sortDropDownList.first;
    initialDate.text = '';
    finalDate.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        title: const Text('Histórico de Compras'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              const Text('Filtro'),
              const SizedBox(width: 5),
              SizedBox(
                width: 50,
                child: TextField(
                  onSubmitted: (id) async {
                    if (id.isEmpty || id == '0') {
                      setState(
                        () {
                          showAllPurchase = true;
                        },
                      );
                    } else {
                      await purchaseController.getSinglePurchase(id);
                      setState(
                        () {
                          showAllPurchase = false;
                        },
                      );
                    }
                  },
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 100,
                child: DropdownButton(
                  value: limitDropDownValue,
                  onChanged: (String? limitId) async {
                    await purchaseController.limitResultPurchase(limitId!);
                    if (limitId == 'Todos') {
                      setState(
                        () {
                          limitDropDownValue = limitId;
                          showAllPurchase = true;
                        },
                      );
                    } else {
                      setState(
                        () {
                          limitDropDownValue = limitId;
                        },
                      );
                    }
                  },
                  items: limitDropDownList.map<DropdownMenuItem<String>>(
                    (String valueList) {
                      return DropdownMenuItem<String>(
                        value: valueList,
                        child: Text(valueList),
                      );
                    },
                  ).toList(),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 100,
                child: DropdownButton(
                  value: sortDropDownValue,
                  onChanged: (String? sort) async {
                    await purchaseController.sortResults(sort!);
                    if (sort == 'asc') {
                      setState(
                        () {
                          sortDropDownValue = sort;
                        },
                      );
                    } else {
                      setState(
                        () {
                          sortDropDownValue = sort;
                        },
                      );
                    }
                  },
                  items: sortDropDownList.map<DropdownMenuItem<String>>(
                    (String valueList) {
                      return DropdownMenuItem<String>(
                        value: valueList,
                        child: Text(valueList),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
          ValueListenableBuilder(
            valueListenable: purchaseController.purchases,
            builder: (_, purchases, __) {
              return showAllPurchase
                  ? SizedBox(
                      height: 500,
                      child: ListView.builder(
                        itemCount: purchaseController.purchases.value.length,
                        itemBuilder: (context, index) {
                          final cartProducts = purchases[index];
                          DateTime date = DateTime.parse(cartProducts.date);
                          DateFormat formattedDate = DateFormat('dd/MM/yyyy');
                          return Card(
                            elevation: 3,
                            child: ExpansionTile(
                              title: Text(
                                  'ID: ${cartProducts.id} - Usuário: ${cartProducts.userID.toString()} - Data: ${formattedDate.format(date)}'),
                              children: [
                                Text(cartProducts.products.toString()),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : ValueListenableBuilder(
                      valueListenable: purchaseController.purchase,
                      builder: (_, purchase, __) {
                        return Card(
                          elevation: 3,
                          child: ExpansionTile(
                            title: Text(
                                'ID: ${purchase.id} - Usuário: ${purchase.userID.toString()} - Data: ${purchase.date.toString()}'),
                            children: [
                              Text(purchase.products.toString()),
                            ],
                          ),
                        );
                      },
                    );
            },
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: TextField(
                    controller: initialDate,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        labelText: 'Data Inicial'),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedInitialDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2020, 1, 1),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedInitialDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedInitialDate);
                        setState(
                          () {
                            initialDate.text = formattedDate;
                          },
                        );
                      }
                    },
                  ),
                ),
                Flexible(
                  child: TextField(
                    controller: finalDate,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        labelText: 'Data Final'),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedFinalDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2020, 1, 30),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedFinalDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedFinalDate);
                        setState(
                          () {
                            finalDate.text = formattedDate;
                          },
                        );
                      }
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    purchaseController.getDateRange(
                        startDate: initialDate.text, endDate: finalDate.text);
                    setState(
                      () {
                        purchaseController.purchases;
                      },
                    );
                  },
                  child: const Text('Filtrar'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
