import 'package:bar_de_bordo/models/price.dart';
import 'package:bar_de_bordo/services/firebase/entity/firestore_document.dart';

class Product extends FirestoreDocument {
  @override
  final String id;

  String name;
  Price price;
  int quantity;

  @override
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'price': price.value, 'quantity': quantity};
  }

  Product(this.id, {required this.name, required this.price, this.quantity = 0})
    : super(collectionPath: 'products');

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      map['id'],
      name: map['name'],
      price: Price(value: map['price']),
      quantity: map['quantity'] ?? 0,
    );
  }

  void addQuantity(int qnt) {
    quantity += qnt;
    update({'quantity': quantity});
  }
}
