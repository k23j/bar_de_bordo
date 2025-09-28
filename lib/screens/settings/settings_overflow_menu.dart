import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsOverflowMenu extends StatelessWidget {
  const SettingsOverflowMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: TextButton(
            onPressed: () => logOut(context),
            child: Text("Sair"),
          ),
        ),
      ],
    );
  }

  void logOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pop();
  }
}
