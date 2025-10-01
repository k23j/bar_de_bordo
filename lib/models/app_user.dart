import 'package:bar_de_bordo/services/firebase/entity/firestore_document.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class AppUser extends FirestoreDocument {
  AppUser({
    required this.id,
    required this.name,
    required this.creationDate,
    this.storeIdList = const [],
    this.selectedStoreId = 0,
  }) : super(collectionPath: 'usr', bStoreItem: false);

  // static Future<AppUser?> userFromFirestore(User fsUsr) async {
  //   try {
  //     DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
  //         .instance
  //         .doc('usr/${fsUsr.uid}')
  //         .get();

  //     Map<String, dynamic>? data = doc.data();

  //     if (data == null) return null;

  //     return AppUser(id: fsUsr.uid, name: data['name']);
  //   } catch (err) {
  //     return null;
  //   }
  // }

  @override
  final String id;

  final String name;
  final DateTime creationDate;
  List<String> storeIdList;
  int selectedStoreId;

  String get selectedStore {
    if (selectedStoreId >= storeIdList.length) {
      selectedStoreId = 0;
    }

    return storeIdList[selectedStoreId];
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'creationDate': creationDate.toIso8601String(),
      'storeIdList': storeIdList,
      'selectedStoreId': selectedStoreId,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'],
      name: map['name'],
      creationDate: DateTime.parse(map['creationDate']),
      storeIdList: (map['storeIdList'] as List<dynamic>).cast<String>(),
      selectedStoreId: map['selectedStoreId'],
    );
  }
}
