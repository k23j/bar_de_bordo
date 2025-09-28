import 'package:firebase_auth/firebase_auth.dart';
import 'package:bar_de_bordo/models/user.dart';

class FirebaseManager {
  FirebaseManager._privateConstructor();

  static final FirebaseManager _instance =
      FirebaseManager._privateConstructor();

  static FirebaseManager get instance => _instance;

  factory FirebaseManager() {
    return _instance;
  }

  // void test() {
  //   User;
  // }

  // Stream<AppUser?> get firebaseCurrentUserStream {
  //   return FirebaseAuth.instance.authStateChanges().map((user) {
  //     if (user == null) return null;
  //     return AppUser.fromFirestore(user);
  //   });
  // }
}
