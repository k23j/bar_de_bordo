import 'package:bar_de_bordo/services/firebase/entity/firestore_entity.dart';
import 'package:bar_de_bordo/services/firebase/typedefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreDocument extends FirestoreEntity {
  // static String get parentPath =>
  //     throw UnimplementedError('Must be implemented in subclass');

  FirestoreDocument({
    required String collectionPath,
    String? copyToPath,
    super.bStoreItem,
  }) : _collectionPath = collectionPath {
    documentRef = FirebaseFirestore.instance.doc(path);

    if (copyToPath != null) {
      copyRef = FirebaseFirestore.instance.doc(copyToPath);
    } else {
      copyRef = null;
    }
  }

  final String _collectionPath;

  late final DocumentReference documentRef;
  late final DocumentReference? copyRef;

  @override
  String get collectionPath => _collectionPath;

  Map<String, dynamic> toMap();

  // factory FirestoreDocument.fromMap(Map<String, dynamic> map) {
  //   throw UnimplementedError('Must be implemented by subclass');
  // }

  static FirestoreDocument fromMap(Map<String, dynamic> map) {
    throw UnimplementedError('fromMap precisa ser implementado');
  }

  Future<bool> saveOnFirestore() async {
    try {
      await Future.wait([
        documentRef.set(toMap()),
        if (copyRef != null) copyRef!.set(toMap()),
      ]);
    } catch (err) {
      print(err);
      return false;
    }

    return true;
  }

  // Future<bool> updateFields(Map<String, dynamic> map) async {
  //   try {
  //     await Future.wait([
  //       documentRef.set(map, SetOptions(merge: true)),
  //       if (copyRef != null) copyRef!.set(map, SetOptions(merge: true)),
  //     ]);
  //   } catch (err) {
  //     print(err);
  //     return false;
  //   }

  //   return true;
  // }

  static Future<T?> loadFromFirestore<T extends FirestoreDocument>({
    required String parentPath,
    required String id,
    required FromMap<T> fromMap,
  }) async {
    try {
      final doc = await FirebaseFirestore.instance.doc('$parentPath/$id').get();
      final Map<String, dynamic>? data = doc.data();

      if (data == null) return null;

      return fromMap(data);
    } catch (err) {
      print(err);
      return null;
    }
  }

  @override
  Future<bool> delete() async {
    try {
      await Future.wait([
        documentRef.delete(),
        if (copyRef != null) copyRef!.delete(),
      ]);
      return true;
    } catch (err) {
      return false;
    }
  }

  void update(Map<String, dynamic> map) {
    try {
      Future.wait([
        documentRef.update(map),
        if (copyRef != null) copyRef!.update(map),
      ]);
    } catch (err) {
      print(err);
    }
  }
}
