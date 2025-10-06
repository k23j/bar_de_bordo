import 'package:bar_de_bordo/models/product.dart';
import 'package:bar_de_bordo/models/sale_product.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class SaleCartNotifier extends ValueNotifier<List<SaleProduct>> {
  SaleCartNotifier() : super([]);

  void addProduct(Product product) {
    SaleProduct? saleProduct = value.firstWhereOrNull(
      (element) => element.id == product.id,
    );
    if (saleProduct == null) {
      saleProduct = SaleProduct.fromProduct(product);
      value.add(saleProduct);
    } else {
      saleProduct.addQuantity();
    }

    notifyListeners();
  }

  void removeProduct(SaleProduct product) {
    value.remove(product);
    notifyListeners();
  }
}
