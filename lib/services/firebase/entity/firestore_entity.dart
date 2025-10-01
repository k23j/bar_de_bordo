import 'package:bar_de_bordo/core/app_state.dart';

abstract class FirestoreEntity {
  String get id;
  String get collectionPath;

  ///If false this entity will be stored in firestore root
  bool bStoreItem;

  FirestoreEntity({this.bStoreItem = true});

  String get path {
    //TODO: change to store
    final String storePath = bStoreItem
        ? '${AppState.instance.currentStore!.path}/'
        : '';
    return '$storePath$collectionPath/$id';
  }

  Future<bool> delete();
}
