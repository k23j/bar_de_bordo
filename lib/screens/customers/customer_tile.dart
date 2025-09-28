import 'package:bar_de_bordo/models/customer.dart';
import 'package:bar_de_bordo/screens/customers/customer_detail_screen.dart';
import 'package:flutter/material.dart';

class CustomerTile extends StatelessWidget {
  const CustomerTile({super.key, required this.data});

  final Customer data;

  void openCustomer(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => CustomerDetailScreen(data)));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => openCustomer(context),
      title: Text(data.name),
      trailing: Text(data.debtAmount.formated, textAlign: TextAlign.end),
    );
  }
}
