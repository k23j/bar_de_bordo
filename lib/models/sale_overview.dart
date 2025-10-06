import 'package:bar_de_bordo/models/customer.dart';
import 'package:bar_de_bordo/models/customer_collection.dart';
import 'package:bar_de_bordo/models/price.dart';
import 'package:bar_de_bordo/models/product.dart';
import 'package:bar_de_bordo/models/sale_cart_notifier.dart';
import 'package:bar_de_bordo/models/sale_product.dart';
import 'package:flutter/widgets.dart';
import 'package:collection/collection.dart';

class SaleOverview {
  SaleOverview({String? customerId}) {
    initCustomerList(customerId);
  }

  void initCustomerList(String? selectedUserId) {
    customerList = _customerCollection.items;
    if (selectedUserId != null) {
      customerList.then(
        (list) => selectedCustomerNotifier.value = list.firstWhereOrNull(
          (e) => e.id == selectedUserId,
        ),
      );
    }
  }

  final CustomerCollection _customerCollection = CustomerCollection();
  ValueNotifier<Customer?> selectedCustomerNotifier = ValueNotifier(null);
  late Future<List<Customer>> customerList;

  void onCustomerChanged(Customer? value) {
    selectedCustomerNotifier.value = value;
  }

  ValueNotifier<Price> get priceNotifier => saleCartNotifier.cartPriceNotifier;

  // final Price price = Price();
  final saleCartNotifier = SaleCartNotifier();

  void addProduct(Product product) {
    saleCartNotifier.addProduct(product);
  }

  void removeProduct(SaleProduct product) {
    saleCartNotifier.removeProduct(product);
  }
}
