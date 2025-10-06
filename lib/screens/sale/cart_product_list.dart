import 'package:bar_de_bordo/models/sale_cart_notifier.dart';
import 'package:bar_de_bordo/models/sale_product.dart';
import 'package:flutter/material.dart';

class CartProductList extends StatelessWidget {
  const CartProductList({required this.notifier, super.key});

  final SaleCartNotifier notifier;

  void onProductRemoved(SaleProduct product) {
    notifier.removeProduct(product);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<SaleProduct>>(
      valueListenable: notifier,
      builder: (context, value, child) {
        return ListView.builder(
          itemCount: value.length,
          itemBuilder: (context, index) => CartProductTile(
            product: value[index],
            onProductRemoved: onProductRemoved,
          ),
        );
      },
    );
  }
}

class CartProductTile extends StatelessWidget {
  const CartProductTile({
    required this.product,
    required this.onProductRemoved,
    super.key,
  });

  final SaleProduct product;

  final void Function(SaleProduct product) onProductRemoved;

  void increment() {
    product.addQuantity();
  }

  void decrement() {
    final int value = product.removeQuantity();
    if (value == 0) onProductRemoved(product);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(onPressed: decrement, icon: Icon(Icons.remove)),
          ValueListenableBuilder(
            valueListenable: product.quantityNotifier,
            builder: (context, value, child) => Text(value.toString()),
          ),
          IconButton(onPressed: increment, icon: Icon(Icons.add)),
          IconButton(
            onPressed: () => onProductRemoved(product),
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
