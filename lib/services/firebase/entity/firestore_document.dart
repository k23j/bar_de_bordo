import 'package:bar_de_bordo/services/firebase/entity/firestore_entity.dart';
import 'package:bar_de_bordo/services/firebase/typedefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreDocument extends FirestoreEntity {
  // static String get parentPath =>
  //     throw UnimplementedError('Must be implemented in subclass');

  FirestoreDocument({required String collectionPath, super.bStoreItem})
    : _collectionPath = collectionPath {
    documentRef = FirebaseFirestore.instance.doc(path);
  }

  final String _collectionPath;

  late final DocumentReference documentRef;

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
      await documentRef.set(toMap());
    } catch (err) {
      print(err);
      return false;
    }

    return true;
  }

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
      await FirebaseFirestore.instance.doc(path).delete();
      return true;
    } catch (err) {
      return false;
    }
  }

  void update(Map<String, int> map) {
    documentRef.update(map);
  }
}
