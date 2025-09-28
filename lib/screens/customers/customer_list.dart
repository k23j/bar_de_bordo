import 'package:bar_de_bordo/models/customer.dart';
import 'package:bar_de_bordo/models/customer_collection.dart';
import 'package:bar_de_bordo/screens/customers/customer_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerList extends StatelessWidget {
  const CustomerList({super.key});

  final Widget noCustomerWidget = const Center(
    child: Text(
      "Nenhum cliente cadastrado.\nToque no botão abaixo para adicionar.",
      textAlign: TextAlign.center,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: StreamBuilder<List<Customer>>(
        // stream: stockStream,
        stream: context.read<CustomerCollection>().itemsStream,
        // initialData:
        //     FirestoreCollection.getInstance<ProductCollection>().stockItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox.shrink();
          }

          if (snapshot.hasError) {
            return noCustomerWidget;
          }

          final customers = snapshot.data;

          if (customers == null || customers.isEmpty) {
            return noCustomerWidget;
          }

          return ListView.builder(
            itemCount: customers.length,
            itemBuilder: (context, index) =>
                CustomerTile(data: customers[index]),
          );
        },
      ),
    );
  }
}
