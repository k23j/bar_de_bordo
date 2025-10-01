import 'dart:async';

import 'package:bar_de_bordo/models/app_user.dart';
import 'package:bar_de_bordo/models/store.dart';
import 'package:bar_de_bordo/services/firebase/entity/firestore_collection.dart';
import 'package:bar_de_bordo/services/firebase/entity/firestore_document.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class AppState {
  AppState._privateConstructor() {
    FirebaseAuth.instance.authStateChanges().listen(updateAppUser);
    // FirebaseManager.instance.firebaseCurrentUserStream.listen(updateUser);
  }

  static AppState? _instance; // = AppState._privateConstructor();

  static AppState get instance {
    if (_instance == null) {
      AppState();
    }
    return _instance!;
  }

  factory AppState() {
    if (_instance != null) return _instance!;

    _instance = AppState._privateConstructor();

    return instance;
  }

  final StreamController<AppUser?> _currentUserController =
      StreamController<AppUser?>.broadcast();

  Stream<AppUser?> get currentUserStream => _currentUserController.stream;

  AppUser? currentUser;
  // AppUser? get currentUser => _currentUser;

  Future<void> updateAppUser(User? user) async {
    currentUser = null;
    _currentUserController.sink.add(null);

    if (user == null) return;

    final AppUser? appUser = await FirestoreDocument.loadFromFirestore<AppUser>(
      parentPath: 'usr',
      id: user.uid,
      fromMap: AppUser.fromMap,
    );
    currentUser = appUser;
    if (currentUser != null) _currentUserController.sink.add(currentUser);

    await onUserLogin(appUser);
  }

  final StreamController<Store?> _currentStoreController =
      StreamController<Store?>.broadcast();

  Stream<Store?> get currentStoreStream => _currentStoreController.stream;

  Store? currentStore;
  // Store? get currentStore => _currentStore;

  Future<Store?> onUserLogin(AppUser? user) async {
    _currentStoreController.sink.add(null);
    if (user == null || user.storeIdList.isEmpty) return null;

    final store = await FirestoreDocument.loadFromFirestore<Store>(
      parentPath: 'str',
      id: user.selectedStore,
      fromMap: Store.fromMap,
    );

    if (store != null) changeStore(store);

    return currentStore;
  }

  void changeStore(Store? store) {
    currentStore = store;
    _currentStoreController.sink.add(currentStore);
  }

  ValueNotifier<Widget?> currentFAB = ValueNotifier(null);
}
