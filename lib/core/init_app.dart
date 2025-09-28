import 'package:bar_de_bordo/core/app_state.dart';
import 'package:bar_de_bordo/models/customer_collection.dart';
import 'package:bar_de_bordo/models/product_collection.dart';
import 'package:bar_de_bordo/services/firebase/entity/firestore_collection.dart';
import 'package:bar_de_bordo/services/firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<bool> initApp() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    AppState();

    // ProductCollection.instance;
    // CustomerCollection.instance;

    // await FirestoreCollection.initializeAllCollections();

    return true;
  } catch (err) {
    print(err);
    return false;
  }
}
