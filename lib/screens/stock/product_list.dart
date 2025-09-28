import 'package:bar_de_bordo/models/product.dart';
import 'package:bar_de_bordo/screens/stock/product_tile.dart';
import 'package:bar_de_bordo/models/product_collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  final Widget noProductWidget = const Center(
    child: Text(
      "Você ainda não adicionou nenhum item.\nToque no botão abaixo para começar.",
      textAlign: TextAlign.center,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
      stream: context.read<ProductCollection>().itemsStream,
      // initialData: FirestoreCollection.getInstance<ProductCollection>().items,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox.shrink();
        }

        if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        }

        final products = snapshot.data;

        if (products == null || products.isEmpty) {
          return Center(child: Text('Nenhum produto disponível.'));
        }

        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) => ProductTile(products[index]),
        );
      },
    );
  }
}
