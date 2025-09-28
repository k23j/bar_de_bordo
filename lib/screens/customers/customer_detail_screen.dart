import 'package:bar_de_bordo/models/customer.dart';
import 'package:flutter/material.dart';

class CustomerDetailScreen extends StatelessWidget {
  const CustomerDetailScreen(this.data, {super.key});

  final Customer data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(data.name)),
      body: const Placeholder(),
    );
  }
}
