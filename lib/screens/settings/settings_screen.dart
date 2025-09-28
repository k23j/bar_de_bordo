import 'package:bar_de_bordo/core/app_state.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(AppState.instance.currentUser?.name ?? 'null'));
  }
}
