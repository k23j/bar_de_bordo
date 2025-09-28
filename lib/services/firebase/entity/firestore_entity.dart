import 'package:bar_de_bordo/core/app_state.dart';

abstract class FirestoreEntity {
  String get id;
  String get collectionPath;

  String get path =>
      '${AppState.instance.currentUser!.path}/$collectionPath/$id';

  Future<bool> delete();
}
