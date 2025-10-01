import 'package:bar_de_bordo/appearance/custom_theme.dart';
import 'package:bar_de_bordo/screens/login_screen.dart';
import 'package:bar_de_bordo/core/app_state.dart';
import 'package:bar_de_bordo/core/init_app.dart';
import 'package:bar_de_bordo/main_menu.dart';
import 'package:bar_de_bordo/loading_screen.dart';
import 'package:bar_de_bordo/models/app_user.dart';
import 'package:bar_de_bordo/user_error_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'services/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initApp();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: customTheme,
      darkTheme: customTheme,
      home: StreamBuilder<AppUser?>(
        stream: AppState.instance.currentUserStream,
        initialData: null,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return UserErrorScreen();
          }

          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return LoadingScreen();
          // }

          if (snapshot.data == null) {
            return LoginScreen();
          }

          return MainMenu();
        },
      ),
    );
  }
}
