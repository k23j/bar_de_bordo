import 'package:bar_de_bordo/models/product.dart';
import 'package:flutter/material.dart';

class ProductStockTile extends StatelessWidget {
  const ProductStockTile(this.data, {super.key});

  final Product data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data.name),
      leadingAndTrailingTextStyle: Theme.of(context).textTheme.bodyMedium,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text(data.quantity.toString())],
      ),
    );
  }
}
