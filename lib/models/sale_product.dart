class SaleProduct {
  final String id;
  final String name;
  final double unitPrice;
  final int quantity;

  double get totalPrice => unitPrice * quantity;

  Map<String, dynamic> toMap() => {
    'id': id,
    'productName': name,
    'price': unitPrice,
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
      unitPrice: map['price'],
      quantity: map['quantity'],
    );
  }
}
