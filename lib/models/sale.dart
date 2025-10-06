import 'package:bar_de_bordo/models/price.dart';
import 'package:bar_de_bordo/models/sale_product.dart';
import 'package:bar_de_bordo/services/firebase/entity/firestore_document.dart';
// import 'package:bar_de_bordo/services/uuid/id_generator.dart';

class Sale extends FirestoreDocument {
  Sale(
    this.id, {
    required this.customerId,
    required this.date,
    required this.productList,
    // required super.collectionPath,
    int? totalPrice,
  }) : _price = (totalPrice != null)
           ? Price(value: totalPrice)
           : Price.sum(productList.map((e) => e.totalPrice)),
       super(
         collectionPath: buildMonthPath(date),
         copyToPath: "customers/$customerId/transactions",
       );

  // Sale.empty({this.customerId})
  //   : id = IdGenerator.instance.generateStringId(),
  //     productList = [],
  //     _price = null,
  //     //TODO: incorrect value if newsalescreen is opened in a month and the sale finished in the next
  //     super(collectionPath: buildMonthPath(DateTime.now()));

  static String buildMonthPath(DateTime date) {
    return 'sales/monthly/${date.year}-${date.month.toString().padLeft(2, '0')}';
  }

  @override
  final String id;

  final String customerId;
  final DateTime date;
  final List<SaleProduct> productList;

  late final Price _price;

  // Price get price {
  //   if (_price == null) {
  //     return calcPrice();
  //   } else {
  //     return _price!;
  //   }
  // }

  // bool isValid() {
  //   return (customerId != null && productList.isNotEmpty);
  // }

  // Price calcPrice(List<SaleProduct> productList) {
  //   return Price.sum(productList.map((e) => e.totalPrice));
  // }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'date': date.toIso8601String(),
      'productList': productList.map((e) => e.toMap()).toList(),
      'price': _price.value,
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
