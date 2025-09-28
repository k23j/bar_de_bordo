import 'dart:async';

import 'package:bar_de_bordo/services/firebase/entity/firestore_collection.dart';
import 'package:bar_de_bordo/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCollection extends FirestoreCollection<Product> {
  ProductCollection()
    : super(collectionPath: 'products', fromMap: Product.fromMap);

  Stream<QuerySnapshot<Object?>> get stockItemsSnapshotStream =>
      firestoreCollection.where('quantity', isGreaterThan: 0).snapshots();

  Future<List<Product>> get stockItems {
    return firestoreCollection.where('quantity', isGreaterThan: 0).get().then((
      snapshot,
    ) {
      return snapshot.docs
          .map((e) => fromMap(e.data() as Map<String, dynamic>))
          .toList();
    });
    // return items.then(
    //   (value) => value.where((product) => product.quantity > 0).toList(),
    // );
  }

  Stream<List<Product>> get stockStream {
    return stockItemsSnapshotStream.map((snapshot) {
      return snapshot.docs
          .map((doc) => fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }
}
  // @override
  // Future<bool> internalInitialization() async {
  //   try {
  //     _stockItemsController = StreamController<List<Product>>.broadcast();
  //     if (!await super.internalInitialization()) return false;

  //     _stockItemMap.addAll(
  //       Map.fromEntries(
  //         items
  //             .where((product) => product.quantity > 0)
  //             .map((product) => MapEntry(product.id, product)),
  //       ),
  //     );
  //     refreshStream();
  //     return true;
  //   } catch (err) {
  //     return false;
  //   }
// }

  // @override
  // Future<bool> deleteItem(Product item) async {
  //   try {
  //     _stockItemMap.remove(item.id);
  //     return super.deleteItem(item);
  //   } catch (err) {
  //     return false;
  //   }
  // }

  // @override
  // Future<bool> addItem(Product item) async {
  //   try {
  //     if (item.quantity > 0) _stockItemMap[item.id] = item;
  //     return super.addItem(item);
  //   } catch (err) {
  //     return false;
  //   }
  // }

  // @override
  // Future<bool> modifyItem(Product item) async {
  //   try {
  //     if (item.quantity == 0) {
  //       _stockItemMap.remove(item.id);
  //     } else if (item.quantity > 0) {
  //       _stockItemMap[item.id] = item;
  //     }
  //     return super.modifyItem(item);
  //   } catch (err) {
  //     return false;
  //   }
  // }

