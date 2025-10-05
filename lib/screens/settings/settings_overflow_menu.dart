import 'package:bar_de_bordo/core/app_state.dart';
import 'package:bar_de_bordo/widgets/change_store_name_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsOverflowMenu extends StatelessWidget {
  SettingsOverflowMenu({super.key});

  void logOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pop();
  }

  void changeStoreName(BuildContext context) {
    showDialog<String?>(
      context: context,
      builder: (context) =>
          ChangeStoreNameDialog(AppState.instance.currentStore!),
    );
  }

  late final Map<String, void Function(BuildContext)> menuItemMap = {
    'Alterar Nome': changeStoreName,
    'Sair': logOut,
  };

  void onSelected(String value, BuildContext context) {
    if (!menuItemMap.containsKey(value)) return;

    menuItemMap[value]!(context);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert),
      onSelected: (value) => onSelected(value, context),
      itemBuilder: (context) => menuItemMap.keys
          .map((e) => PopupMenuItem(value: e, child: Text(e)))
          .toList(),
    );
  }
}
