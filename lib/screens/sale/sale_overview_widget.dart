import 'package:bar_de_bordo/models/customer.dart';
import 'package:bar_de_bordo/models/customer_collection.dart';
import 'package:bar_de_bordo/models/price.dart';
import 'package:bar_de_bordo/models/sale_overview.dart';
import 'package:bar_de_bordo/screens/sale/cart_product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class SaleOverviewWidget extends StatefulWidget {
  const SaleOverviewWidget({required this.data, super.key});
  final SaleOverview data;

  @override
  State<SaleOverviewWidget> createState() => _SaleOverviewWidgetState();
}

class _SaleOverviewWidgetState extends State<SaleOverviewWidget> {
  // late Future<List<Customer>> customerList;

  // Customer? customer;

  // Price price = Price();

  // @override
  // void initState() {
  //   //TODO: This only works when using the saleCartNotifier
  //   //we need this to work when using the SaleProduct directly
  //   widget.saleCartNotifier.addListener(onCartChanged);
  //   setInitialData();
  //   super.initState();
  // }

  // void onCartChanged() {
  //   widget.sale.productList = widget.saleCartNotifier.value;
  //   //TODO: Optimize
  //   setState(() {
  //     price = widget.sale.price;
  //   });
  // }

  // void setInitialData() {
  //   customerList = context.read<CustomerCollection>().items;
  //   customerList.then((value) {
  //     if (mounted) {
  //       setState(() {
  //         customer = value.firstWhereOrNull(
  //           (e) => e.id == widget.sale.customerId,
  //         );
  //       });
  //     }
  //   });
  // }

  // void onCustomerChanged(Customer? value) {
  //   setState(() {
  //     customer = value;
  //     widget.sale.customerId = value?.id;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Cliente:'),
            const SizedBox(width: 12),
            FutureBuilder<List<Customer>>(
              future: widget.data.customerList,
              initialData: [],
              builder: (context, snapshot) {
                return ValueListenableBuilder(
                  valueListenable: widget.data.selectedCustomerNotifier,
                  builder: (context, selectedCustomer, child) =>
                      DropdownButton<Customer?>(
                        menuMaxHeight: 64,

                        onChanged: widget.data.onCustomerChanged,
                        value: selectedCustomer,
                        items: snapshot.data!.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e.name),
                          );
                        }).toList(),
                      ),
                );
              },
            ),
            const SizedBox(width: 12),
            ValueListenableBuilder(
              valueListenable: widget.data.priceNotifier,
              builder: (context, price, child) => Text(price.formated),
            ),
          ],
        ),
        Expanded(child: CartProductList(overview: widget.data)),
      ],
    );
  }
}
