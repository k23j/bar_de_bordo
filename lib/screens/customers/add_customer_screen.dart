import 'package:bar_de_bordo/models/customer.dart';
import 'package:bar_de_bordo/models/phone_number.dart';
import 'package:bar_de_bordo/models/price.dart';
import 'package:bar_de_bordo/services/uuid/id_generator.dart';
import 'package:bar_de_bordo/widgets/fab_add.dart';
import 'package:flutter/material.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController areaCodeController;
  late final TextEditingController numberController;

  @override
  void initState() {
    nameController = TextEditingController();
    areaCodeController = TextEditingController(text: '21');
    numberController = TextEditingController();

    super.initState();
  }

  void add() {
    if (!(_formKey.currentState!.validate())) return;

    try {
      final Customer customer = Customer(
        IdGenerator.instance.generateStringId(),
        name: nameController.text,
        debtAmount: Price(),
        phone: PhoneNumber(
          areaCode: areaCodeController.text,
          localNumber: numberController.text,
        ),
      );

      customer.saveOnFirestore();

      if (!mounted) return;

      Navigator.of(context).pop(customer);
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Novo Cliente')),
      floatingActionButton: AddFAB(add),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o nome do cliente';
                  }
                  if (value.trim().length < 3) {
                    return 'O nome deve ter pelo menos 3 caracteres';
                  }
                  return null;
                },
              ),

              Row(
                children: [
                  SizedBox(
                    width: 48,
                    child: TextFormField(
                      controller: areaCodeController,
                      decoration: InputDecoration(labelText: 'DDD'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Informe o DDD';
                        }

                        final ddd = value.trim();
                        if (!RegExp(r'^\d{2}$').hasMatch(ddd)) {
                          return 'DDD inválido';
                        }

                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: numberController,
                      decoration: InputDecoration(labelText: 'Número'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Informe o número';
                        }

                        final number = value.replaceAll(RegExp(r'[\s-]'), '');

                        if (!RegExp(r'^\d{9}$').hasMatch(number)) {
                          return 'Número inválido';
                        }

                        numberController.text =
                            '${number.substring(0, 5)}-${number.substring(5)}';

                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
