import 'package:bar_de_bordo/models/phone_number.dart';
import 'package:bar_de_bordo/models/price.dart';
import 'package:bar_de_bordo/services/firebase/entity/firestore_document.dart';

class Customer extends FirestoreDocument {
  @override
  final String id;

  String name;
  PhoneNumber phone;
  Price debtAmount;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone.toString(),
      'debt': debtAmount.toString(),
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      map['id'],
      name: map['name'],
      phone: PhoneNumber.fromString(map['phone']),
      debtAmount: (map['debt'] != null)
          ? Price.fromString(map['debt'])
          : Price(),
    );
  }

  Customer(
    this.id, {
    required this.debtAmount,
    required this.name,
    required this.phone,
  }) : super(collectionPath: 'customers');
}
