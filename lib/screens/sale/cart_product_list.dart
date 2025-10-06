import 'package:bar_de_bordo/models/sale_cart_notifier.dart';
import 'package:bar_de_bordo/models/sale_overview.dart';
import 'package:bar_de_bordo/models/sale_product.dart';
import 'package:flutter/material.dart';

class CartProductList extends StatelessWidget {
  const CartProductList({required this.overview, super.key});

  final SaleOverview overview;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<SaleProduct>>(
      valueListenable: overview.saleCartNotifier,
      builder: (context, value, child) {
        return ListView.builder(
          itemCount: value.length,
          itemBuilder: (context, index) => CartProductTile(
            product: value[index],
            onProductRemoved: overview.removeProduct,
            increment: overview.saleCartNotifier.addQuantity,
            decrement: overview.saleCartNotifier.subtractQuantity,
          ),
        );
      },
    );
  }
}

class CartProductTile extends StatelessWidget {
  const CartProductTile({
    required this.product,
    required this.increment,
    required this.decrement,
    required this.onProductRemoved,
    super.key,
  });

  final SaleProduct product;

  final void Function(SaleProduct product) onProductRemoved;
  final void Function({required String id, int qnt}) increment;
  final void Function({required String id, int qnt}) decrement;

  // void _increment() {
  //   product.addQuantity();
  // }

  // void _decrement() {
  //   final int value = product.subtractQuantity();
  //   if (value == 0) onProductRemoved(product);
  // }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () => decrement(id: product.id, qnt: 1),
            icon: Icon(Icons.remove),
          ),
          ValueListenableBuilder(
            valueListenable: product.quantityNotifier,
            builder: (context, value, child) => Text(value.toString()),
          ),
          IconButton(
            onPressed: () => increment(id: product.id, qnt: 1),
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () => onProductRemoved(product),
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
