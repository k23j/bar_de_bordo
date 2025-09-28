import 'package:bar_de_bordo/models/product.dart';
import 'package:bar_de_bordo/screens/stock/product_stock_tile.dart';
import 'package:bar_de_bordo/models/product_collection.dart';
import 'package:bar_de_bordo/services/firebase/entity/firestore_collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StockList extends StatelessWidget {
  const StockList({super.key});

  final Widget noStockWidget = const Center(
    child: Text(
      "Seu estoque está vazio.\nToque no botão abaixo para adicionar.",
      textAlign: TextAlign.center,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
      // stream: stockStream,
      stream: context.read<ProductCollection>().stockStream,
      // initialData:
      //     FirestoreCollection.getInstance<ProductCollection>().stockItems,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox.shrink();
        }

        if (snapshot.hasError) {
          return noStockWidget;
        }

        final products = snapshot.data;

        if (products == null || products.isEmpty) {
          return noStockWidget;
        }

        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) => ProductStockTile(products[index]),
        );
      },
    );
  }
}
