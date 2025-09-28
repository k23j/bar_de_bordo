import 'package:bar_de_bordo/models/sale.dart';
import 'package:bar_de_bordo/services/firebase/entity/firestore_collection.dart';

class SaleCollection extends FirestoreCollection<Sale> {
  SaleCollection() : super(collectionPath: 'sales', fromMap: Sale.fromMap);
}
