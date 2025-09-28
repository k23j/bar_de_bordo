import 'package:bar_de_bordo/models/customer.dart';
import 'package:bar_de_bordo/services/firebase/entity/firestore_collection.dart';

class CustomerCollection extends FirestoreCollection<Customer> {
  CustomerCollection()
    : super(collectionPath: 'customers', fromMap: Customer.fromMap);
}
