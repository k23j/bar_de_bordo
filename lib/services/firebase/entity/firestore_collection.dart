import 'dart:async';

import 'package:bar_de_bordo/services/firebase/entity/firestore_document.dart';
import 'package:bar_de_bordo/services/firebase/entity/firestore_entity.dart';
import 'package:bar_de_bordo/services/firebase/typedefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

abstract class FirestoreCollection<T extends FirestoreDocument>
    extends FirestoreEntity
    with ChangeNotifier {
  // final String collectionPath;

  final FromMap<T> fromMap;

  FirestoreCollection({required String collectionPath, required this.fromMap})
    : _collectionPath = collectionPath;

  final String _collectionPath;

  @override
  String get collectionPath => _collectionPath;

  @override
  String get id => '';

  // @override
  // String get collectionPath => collectionPath;

  CollectionReference get firestoreCollection =>
      FirebaseFirestore.instance.collection(path);

  Stream<QuerySnapshot> get snapshotStream => firestoreCollection.snapshots();

  Stream<List<T>> get itemsStream {
    return snapshotStream.map((snapshot) {
      return snapshot.docs
          .map((doc) => fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  Future<List<T>> get items {
    return firestoreCollection.get().then((snapshot) {
      return snapshot.docs
          .map((e) => fromMap(e.data() as Map<String, dynamic>))
          .toList();
    });
  }

  Future<bool> deleteItem(T item) async {
    try {
      final bool success = await item.delete();
      if (success) notifyListeners();

      return success;
    } catch (err) {
      return false;
    }
  }

  Future<bool> addItem(T item) async {
    try {
      final bool success = await item.saveOnFirestore();
      if (success) notifyListeners();

      return success;
    } catch (err) {
      return false;
    }
  }

  Future<bool> modifyItem(T item) async {
    try {
      final bool success = await item.saveOnFirestore();
      if (success) notifyListeners();

      return success;
    } catch (err) {
      return false;
    }
  }

  @override
  Future<bool> delete() async {
    throw ("Can't delete an entire collection");
  }
}
