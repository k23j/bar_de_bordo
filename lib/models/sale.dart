import 'package:bar_de_bordo/models/price.dart';
import 'package:bar_de_bordo/models/sale_product.dart';
import 'package:bar_de_bordo/services/firebase/entity/firestore_document.dart';

class Sale extends FirestoreDocument {
  Sale(
    this.id, {
    required this.customerId,
    required this.date,
    required this.productList,
    // required super.collectionPath,
    int? totalPrice,
  }) : super(
         collectionPath: buildMonthPath(date),
         copyToPath: "customers/$customerId/transactions",
       ) {
    if (totalPrice == null) {
      price = Price.sum(productList.map((e) => e.totalPrice));
    } else {
      price = Price(value: totalPrice);
    }
  }

  static String buildMonthPath(DateTime date) {
    return 'sales/${date.year}-${date.month.toString().padLeft(2, '0')}';
  }

  @override
  final String id;

  final String customerId;
  final DateTime date;
  final List<SaleProduct> productList;
  late final Price price;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'date': date.toIso8601String(),
      'productList': productList.map((e) => e.toMap()).toList(),
      'price': price.value,
    };
  }

  factory Sale.fromMap(Map<String, dynamic> map) {
    List<SaleProduct> list = (map['productList'] as List)
        .map((e) => SaleProduct.fromMap(e as Map<String, dynamic>))
        .toList();

    return Sale(
      map['id'],
      customerId: map['customerId'],
      date: DateTime.parse(map['date']),
      productList: list,
      totalPrice: map['price'],
    );
  }
}
