import 'package:flutter/material.dart';

// final ThemeData customTheme = ThemeData(
//   colorScheme: customColorScheme,
//   brightness: Brightness.dark,
// );

final ThemeData customTheme = ThemeData(
  colorScheme: customColorScheme,
  brightness: Brightness.dark,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: customColorScheme.background,
    selectedItemColor: customColorScheme.primary,
    unselectedItemColor: customColorScheme.onBackground.withOpacity(0.6),
    elevation: 8,
    type: BottomNavigationBarType.fixed,
  ),
);

final ColorScheme customColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.lightBlue,
  brightness: Brightness.dark,
);
