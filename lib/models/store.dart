import 'package:bar_de_bordo/services/firebase/entity/firestore_document.dart';
import 'package:flutter/material.dart';

class Store extends FirestoreDocument {
  Store(this.id, {required String name, required this.creationDate})
    : _name = name,
      super(collectionPath: 'str', bStoreItem: false);

  @override
  final String id;

  String _name;
  String get name => _name;
  DateTime creationDate;

  late ValueNotifier<String> nameNotifier = ValueNotifier(name);

  void changeStoreName(String newName) {
    if (nameValidator(newName) != null) return;

    _name = newName;
    nameNotifier.value = newName;

    saveOnFirestore();
  }

  static String? nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'O nome da loja é obrigatório';
    }
    if (value.trim().length < 3) {
      return 'O nome deve ter pelo menos 3 caracteres';
    }
    return null;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'creationDate': creationDate.toIso8601String(),
    };
  }

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      map['id'],
      name: map['name'],
      creationDate: DateTime.parse(map['creationDate']),
    );
  }
}
