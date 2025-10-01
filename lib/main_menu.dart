import 'package:bar_de_bordo/core/app_state.dart';
import 'package:bar_de_bordo/screens/customers/customer_screen.dart';
import 'package:bar_de_bordo/screens/home_screen.dart';
import 'package:bar_de_bordo/screens/settings/settings_overflow_menu.dart';
import 'package:bar_de_bordo/screens/settings/settings_screen.dart';
import 'package:bar_de_bordo/screens/stock/stock_screen.dart';
import 'package:bar_de_bordo/widgets/fab_add.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int selectedId = 0;

  void changeTab(int? id) {
    if (id == null || id == selectedId) return;

    AppState.instance.currentFAB.value = null;

    setState(() {
      selectedId = id;
    });
  }

  Widget get currentScreen {
    switch (selectedId) {
      case 1:
        return CustomersScreen();
      case 2:
        return ProductsScreen();
      case 3:
        return SettingsScreen();

      default:
        return HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder<String>(
          valueListenable: AppState.instance.currentStore!.nameNotifier,
          builder: (context, value, child) => Text(value),
        ),
        actions: [if (selectedId == 3) SettingsOverflowMenu()],
      ),
      body: currentScreen,
      floatingActionButton: ValueListenableBuilder<Widget?>(
        valueListenable: AppState.instance.currentFAB,
        builder: (context, fab, _) => fab ?? SizedBox.shrink(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: changeTab,
        currentIndex: selectedId,
        items: [
          BottomNavigationBarItem(label: 'Início', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'Clientes', icon: Icon(Icons.groups)),
          BottomNavigationBarItem(
            label: 'Produtos',
            icon: Icon(Icons.local_grocery_store_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Configurações',
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
