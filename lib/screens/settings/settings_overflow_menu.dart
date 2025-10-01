import 'package:bar_de_bordo/core/app_state.dart';
import 'package:bar_de_bordo/widgets/change_store_name_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsOverflowMenu extends StatelessWidget {
  const SettingsOverflowMenu({super.key});

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

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: TextButton(
            onPressed: () => changeStoreName(context),
            child: Text("Alterar nome"),
          ),
        ),
        PopupMenuItem(
          child: TextButton(
            onPressed: () => logOut(context),
            child: Text("Sair"),
          ),
        ),
      ],
    );
  }
}
