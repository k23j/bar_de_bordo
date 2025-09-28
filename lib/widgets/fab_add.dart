import 'package:flutter/material.dart';

class AddFAB extends StatelessWidget {
  const AddFAB(this.onFabPressed, {super.key});

  final VoidCallback onFabPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onFabPressed,
      child: Icon(Icons.add),
    );
  }
}
