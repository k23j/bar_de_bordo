import 'package:bar_de_bordo/models/customer.dart';
import 'package:bar_de_bordo/screens/sale/new_sale_screen.dart';
import 'package:flutter/material.dart';

class CustomerDetailScreen extends StatelessWidget {
  const CustomerDetailScreen(this.data, {super.key});

  final Customer data;

  void newSale(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewSaleScreen(customerId: data.id),
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
