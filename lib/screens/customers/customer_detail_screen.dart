import 'package:bar_de_bordo/models/customer.dart';
import 'package:bar_de_bordo/models/customer_collection.dart';
import 'package:bar_de_bordo/screens/sale/new_sale_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerDetailScreen extends StatelessWidget {
  const CustomerDetailScreen(this.data, {super.key});

  final Customer data;

  void newSale(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider<CustomerCollection>(
          create: (context) => CustomerCollection(),
          child: NewSaleScreen(customerId: data.id),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(data.name)),
      body: const Placeholder(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => newSale(context),
        child: Icon(Icons.local_grocery_store),
      ),
    );
  }
}
