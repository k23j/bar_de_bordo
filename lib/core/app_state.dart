import 'dart:async';

import 'package:bar_de_bordo/models/user.dart';
import 'package:bar_de_bordo/services/firebase/entity/firestore_collection.dart';
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

  AppUser? _currentUser;
  AppUser? get currentUser => _currentUser;

  Future<void> updateAppUser(User? user) async {
    _currentUser = null;
    _currentUserController.sink.add(null);

    if (user == null) return;

    final appUser = await AppUser.userFromFirestore(user);
    _currentUser = appUser;
    _currentUserController.add(appUser);
    await onUserLogin();
  }

  Future<bool> onUserLogin() async {
    // return await FirestoreCollection.initializeAllCollections();
    return true;
  }

  ValueNotifier<Widget?> currentFAB = ValueNotifier(null);
}
