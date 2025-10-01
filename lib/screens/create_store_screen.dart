import 'package:bar_de_bordo/core/app_state.dart';
import 'package:bar_de_bordo/models/app_user.dart';
import 'package:bar_de_bordo/models/store.dart';
import 'package:bar_de_bordo/services/uuid/id_generator.dart';
import 'package:flutter/material.dart';

class CreateStoreScreen extends StatefulWidget {
  const CreateStoreScreen({super.key});

  @override
  State<CreateStoreScreen> createState() => _CreateStoreScreenState();
}

class _CreateStoreScreenState extends State<CreateStoreScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Bar de Bordo');

  bool bIsCreating = false;

  void submit() async {
    //Return if form is invalid
    if (!(_formKey.currentState!.validate())) return;
    setState(() {
      bIsCreating = true;
    });
    try {
      final String storeId = IdGenerator.instance.generateStringId();
      final newStore = Store(
        storeId,
        name: _nameController.text,
        creationDate: DateTime.now(),
      );
      final AppUser user = AppState.instance.currentUser!;

      user.storeIdList.add(storeId);
      user.selectedStoreId = user.storeIdList.length - 1;

      await Future.wait([user.saveOnFirestore(), newStore.saveOnFirestore()]);

      AppState.instance.changeStore(newStore);
    } catch (err) {
      print(err);
    }

    setState(() {
      bIsCreating = false;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 48.0),
        child: FloatingActionButton(
          onPressed: bIsCreating ? null : submit,
          child: Icon(Icons.arrow_forward),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 128),
                Text(
                  'Nova Loja',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(label: Text('Nome da Loja')),
                  validator: Store.nameValidator,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
