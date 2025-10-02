import 'package:bar_de_bordo/models/price.dart';

class SaleProduct {
  final String id;
  final String name;
  final Price unitPrice;
  final int quantity;

  Price get totalPrice => unitPrice * quantity;

  Map<String, dynamic> toMap() => {
    'id': id,
    'productName': name,
    'price': unitPrice.value,
    'quantity': quantity,
  };

  const SaleProduct({
    required this.id,
    required this.name,
    required this.unitPrice,
    required this.quantity,
  });

  factory SaleProduct.fromMap(Map<String, dynamic> map) {
    return SaleProduct(
      id: map['id'],
      name: map['productName'],
      unitPrice: Price(value: map['price']),
      quantity: map['quantity'],
    );
  }
}
