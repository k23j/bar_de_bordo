import 'package:bar_de_bordo/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddStockScreen extends StatefulWidget {
  const AddStockScreen(this.productList, {super.key});

  final Future<List<Product>> productList;

  @override
  State<AddStockScreen> createState() => _AddStockScreenState();
}

class _AddStockScreenState extends State<AddStockScreen> {
  Product? product;

  final formKey = GlobalKey<FormState>();
  final quantityController = TextEditingController();

  void onChangeProduct(Product? value) {
    setState(() {
      product = value!;
    });
  }

  void addStock() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final int quantity = int.parse(quantityController.text);

    product?.addQuantity(quantity);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Estoque')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              FutureBuilder<List<Product>>(
                future: widget.productList,
                builder: (context, value) {
                  if (!value.hasData) return SizedBox.shrink();
                  product ??= value.data![0];
                  return DropdownButton(
                    items: value.data!
                        .map(
                          (product) => DropdownMenuItem<Product>(
                            value: product,
                            child: Text(product.name),
                          ),
                        )
                        .toList(),
                    onChanged: onChangeProduct,
                    value: product,
                  );
                },
              ),
              TextFormField(
                controller: quantityController,
                decoration: InputDecoration(
                  label: Text('Quantidade'),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // Only allows digits
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma quantidade';
                  }
                  final intValue = int.tryParse(value);
                  if (intValue == null || intValue <= 0) {
                    return 'Valor inválido.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addStock,
        child: Icon(Icons.add),
      ),
    );
  }
}
