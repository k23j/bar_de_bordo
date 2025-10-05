import 'package:bar_de_bordo/models/customer.dart';
import 'package:bar_de_bordo/models/customer_collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class NewSaleScreen extends StatefulWidget {
  const NewSaleScreen({this.customerId, super.key});

  final String? customerId;

  @override
  State<NewSaleScreen> createState() => _NewSaleScreenState();
}

class _NewSaleScreenState extends State<NewSaleScreen> {
  late Future<List<Customer>> customerList;
  String? customerId;

  Customer? customer;

  @override
  void initState() {
    setInitialData();
    super.initState();
  }

  void setInitialData() async {
    customerId = widget.customerId;
    customerList = context.read<CustomerCollection>().items;
    customerList.then((value) {
      setState(() {
        customer = value.firstWhereOrNull((e) => e.id == customerId);
      });
    });
  }

  void onCustomerChanged(Customer? value) {
    setState(() {
      customer = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nova Venda')),
      body: Column(
        children: [
          Row(
            children: [
              Text('Cliente:'),
              const SizedBox(width: 12),
              FutureBuilder<List<Customer>>(
                future: customerList,
                initialData: [],
                builder: (context, snapshot) {
                  return DropdownButton<Customer?>(
                    menuMaxHeight: 64,

                    onChanged: onCustomerChanged,
                    value: customer,
                    items: snapshot.data!.map((e) {
                      return DropdownMenuItem(value: e, child: Text(e.name));
                    }).toList(),
                  );
                },
              ),
            ],
          ),
          Text('F'),
          Text('F'),
        ],
      ),
    );
  }
}
