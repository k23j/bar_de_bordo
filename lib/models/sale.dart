import 'package:bar_de_bordo/models/sale_product.dart';
import 'package:bar_de_bordo/services/firebase/entity/firestore_document.dart';

class Sale extends FirestoreDocument {
  Sale(
    this.id, {
    required this.date,
    required this.productList,
    required super.collectionPath,
  });

  @override
  final String id;

  final DateTime date;
  final List<SaleProduct> productList;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'productList': productList.map((e) => e.toMap()).toList(),
    };
  }

  factory Sale.fromMap(Map<String, dynamic> map) {
    List<SaleProduct> list = (map['productList'] as List)
        .map((e) => SaleProduct.fromMap(e as Map<String, dynamic>))
        .toList();

    return Sale(
      map['id'],
      collectionPath: 'sales',
      date: DateTime.parse(map['date']),
      productList: list,
    );
  }
}
