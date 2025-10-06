import 'package:bar_de_bordo/models/price.dart';
import 'package:bar_de_bordo/models/product.dart';
import 'package:flutter/material.dart';

class SaleProduct {
  final String id;
  final String name;
  final Price unitPrice;
  int get quantity => quantityNotifier.value;

  final void Function()? onRemoved;

  late final ValueNotifier<int> quantityNotifier;

  Price get totalPrice => unitPrice * quantity;

  int addQuantity([int other = 1]) {
    assert(other > 0);
    if (other <= 0) return quantity;
    quantityNotifier.value += other;
    return quantity;
  }

  int subtractQuantity([int other = 1]) {
    if (quantity - other <= 0) {
      quantityNotifier.value = 0;

      onRemoved?.call();
      return 0;
    } else {
      quantityNotifier.value -= other;
      return quantity;
    }
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'productName': name,
    'price': unitPrice.value,
    'quantity': quantity,
  };

  SaleProduct({
    required this.id,
    required this.name,
    required this.unitPrice,
    int quantity = 1,
    this.onRemoved,
  }) {
    quantityNotifier = ValueNotifier(quantity);
  }

  SaleProduct.fromProduct(Product product, {this.onRemoved})
    : id = product.id,
      name = product.name,
      unitPrice = product.price,
      quantityNotifier = ValueNotifier(1);

  factory SaleProduct.fromMap(Map<String, dynamic> map) {
    return SaleProduct(
      id: map['id'],
      name: map['productName'],
      unitPrice: Price(value: map['price']),
      quantity: map['quantity'],
    );
  }
}
