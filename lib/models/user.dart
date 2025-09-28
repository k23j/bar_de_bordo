import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  AppUser({required this.id, required this.name});

  static Future<AppUser?> userFromFirestore(User fsUsr) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
          .instance
          .doc('usr/${fsUsr.uid}')
          .get();

      Map<String, dynamic>? data = doc.data();

      if (data == null) return null;

      return AppUser(id: fsUsr.uid, name: data['name']);
    } catch (err) {
      return null;
    }
  }

  final String id;
  final String name;

  String get path => 'usr/$id';
}
