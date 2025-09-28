import 'package:bar_de_bordo/core/app_state.dart';
import 'package:bar_de_bordo/models/product.dart';
import 'package:bar_de_bordo/models/product_collection.dart';
import 'package:bar_de_bordo/screens/stock/add_product_screen.dart';
import 'package:bar_de_bordo/screens/stock/add_stock_screen.dart';
import 'package:bar_de_bordo/screens/stock/product_list.dart';
import 'package:bar_de_bordo/screens/stock/stock_list.dart';
import 'package:bar_de_bordo/widgets/fab_add.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen>
    with TickerProviderStateMixin {
  late TabController controller;

  late Future<List<Product>> productList; // = [] as Future<List<Product>?>;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppState.instance.currentFAB.value = AddFAB(add);
    });

    controller = TabController(length: 2, vsync: this);

    super.initState();
  }

  void add() {
    if (controller.animation?.value.round() == 0) {
      addStock();
    } else {
      addProduct();
    }
  }

  void addStock() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AddStockScreen(productList)),
    );
  }

  void addProduct() {
    Navigator.of(context).push(
      MaterialPageRoute<Product>(builder: (context) => AddProductScreen()),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: controller,
          tabs: [
            Tab(text: 'Estoque'),
            Tab(text: 'Produtos'),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            key: ValueKey(AppState.instance.currentUser),
            child: ChangeNotifierProvider<ProductCollection>(
              create: (context) => ProductCollection(),
              child: TabBarView(
                controller: controller,

                children: [
                  Builder(
                    builder: (context) {
                      productList = context.read<ProductCollection>().items;
                      return const StockList();
                    },
                  ),
                  const ProductList(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
