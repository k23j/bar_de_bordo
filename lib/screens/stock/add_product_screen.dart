import 'package:bar_de_bordo/models/price.dart';
import 'package:bar_de_bordo/models/product.dart';
import 'package:bar_de_bordo/models/product_collection.dart';
import 'package:bar_de_bordo/services/firebase/entity/firestore_collection.dart';
import 'package:bar_de_bordo/services/uuid/id_generator.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({this.product, super.key});

  final Product? product;

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController priceController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.product?.name);
    priceController = TextEditingController(
      text: widget.product?.price.decimal.toString(),
    );

    super.initState();
  }

  bool _isCreating = false;

  void addProduct() async {
    try {
      if (!_formKey.currentState!.validate()) return;

      setState(() {
        _isCreating = true;
      });

      Product product = Product(
        widget.product?.id ?? IdGenerator.instance.generateStringId(),
        name: nameController.text,
        price: Price.fromString(priceController.text),
      );

      // await product.saveOnFirestore();

      // await product.saveOnFirestore();
      product.saveOnFirestore();

      // await FirestoreCollection.getInstance<ProductCollection>().addItem(
      //   product,
      // );

      if (!mounted) return;

      Navigator.of(context).pop(product);
    } catch (err) {
      print(err);
      setState(() {
        _isCreating = false;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _isCreating
          ? FloatingActionButton(
              onPressed: null,
              child: FractionallySizedBox(
                widthFactor: .6,
                heightFactor: .6,
                child: CircularProgressIndicator(),
              ),
            )
          : FloatingActionButton(
              onPressed: addProduct,
              child: Icon(Icons.check),
            ),
      appBar: AppBar(title: Text('Adicionar Novo Produto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Produto'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o nome do produto';
                  }
                  if (value.trim().length < 3) {
                    return 'O nome deve ter pelo menos 3 caracteres';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o preço';
                  }
                  final parsed = double.tryParse(value.replaceAll(',', '.'));
                  if (parsed == null || parsed <= 0) {
                    return 'Preço inválido';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
