import 'package:bar_de_bordo/models/sale.dart';
import 'package:bar_de_bordo/services/firebase/entity/firestore_collection.dart';

class SaleCollection extends FirestoreCollection<Sale> {
  SaleCollection(DateTime date)
    : super(collectionPath: Sale.buildMonthPath(date), fromMap: Sale.fromMap);
}
