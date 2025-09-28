import 'package:bar_de_bordo/models/customer_collection.dart';
import 'package:bar_de_bordo/screens/customers/add_customer_screen.dart';
import 'package:bar_de_bordo/screens/customers/customer_list.dart';
import 'package:bar_de_bordo/widgets/fab_add.dart';
import 'package:flutter/material.dart';
import 'package:bar_de_bordo/core/app_state.dart';
import 'package:provider/provider.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppState.instance.currentFAB.value = AddFAB(add);
    });

    super.initState();
  }

  void add() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => AddCustomerScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CustomerCollection>(
      create: (context) => CustomerCollection(),
      child: const CustomerList(),
    );
  }
}
