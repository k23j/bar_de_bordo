import 'package:bar_de_bordo/services/firebase/entity/firestore_document.dart';

class Store extends FirestoreDocument {
  Store(this.id, {required this.name})
    : super(collectionPath: 'str', bStoreItem: false);

  @override
  final String id;

  String name;

  @override
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(map['id'], name: map['name']);
  }
}
