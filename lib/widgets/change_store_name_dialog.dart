import 'package:bar_de_bordo/models/store.dart';
import 'package:flutter/material.dart';

class ChangeStoreNameDialog extends StatelessWidget {
  ChangeStoreNameDialog(this.store, {super.key});

  final Store store;

  late final TextEditingController _controller = TextEditingController(
    text: store.name,
  );

  void submit(BuildContext context) {
    store.changeStoreName(_controller.text);
    Navigator.of(context).pop();
  }

  void cancel(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () => cancel(context),
          child: Text(
            'Cancelar',
            style: TextStyle().copyWith(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () => submit(context),
          child: Text(
            'Alterar',
            style: TextStyle().copyWith(color: Colors.green),
          ),
        ),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Trocar nome da loja',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            decoration: InputDecoration(label: Text('Novo Nome')),
            onSubmitted: (value) => submit(context),
          ),
        ],
      ),
    );
  }
}
