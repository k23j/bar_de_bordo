import 'package:bar_de_bordo/models/customer.dart';
import 'package:bar_de_bordo/models/customer_collection.dart';
import 'package:bar_de_bordo/models/product.dart';
import 'package:bar_de_bordo/models/product_collection.dart';
import 'package:bar_de_bordo/models/sale.dart';
import 'package:bar_de_bordo/models/sale_cart_notifier.dart';
import 'package:bar_de_bordo/screens/sale/cart_product_list.dart';
import 'package:bar_de_bordo/screens/sale/sale_overview.dart';
import 'package:bar_de_bordo/screens/sale/sale_product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class NewSaleScreen extends StatefulWidget {
  const NewSaleScreen({this.customerId, super.key});

  final String? customerId;

  @override
  State<NewSaleScreen> createState() => _NewSaleScreenState();
}

class _NewSaleScreenState extends State<NewSaleScreen> {
  final productCollection = ProductCollection();

  late final sale = Sale.empty(customerId: widget.customerId);
  final saleCartNotifier = SaleCartNotifier();

  void addProduct(Product product) {
    saleCartNotifier.addProduct(product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nova Venda')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Builder(
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.max,

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 3,
                  child: ChangeNotifierProvider<CustomerCollection>(
                    create: (context) => CustomerCollection(),
                    child: SaleOverview(
                      sale: sale,
                      saleCartNotifier: saleCartNotifier,
                    ),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text('Cliente:'),
                //     const SizedBox(width: 12),
                //     FutureBuilder<List<Customer>>(
                //       future: customerList,
                //       initialData: [],
                //       builder: (context, snapshot) {
                //         return DropdownButton<Customer?>(
                //           menuMaxHeight: 64,

                //           onChanged: onCustomerChanged,
                //           value: customer,
                //           items: snapshot.data!.map((e) {
                //             return DropdownMenuItem(
                //               value: e,
                //               child: Text(e.name),
                //             );
                //           }).toList(),
                //         );
                //       },
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 256,
                //   width: double.infinity,
                //   child: CartProductList(notifier: saleCartNotifier),
                // ),
                Flexible(
                  flex: 7,
                  child: FutureBuilder(
                    future: productCollection.items,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          snapshot.hasError ||
                          snapshot.data == null ||
                          snapshot.data!.isEmpty) {
                        return SizedBox.expand();
                      }

                      return SaleProductList(
                        productList: snapshot.data!,
                        addProduct: addProduct,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
