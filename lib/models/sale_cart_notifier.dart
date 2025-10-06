import 'package:bar_de_bordo/models/price.dart';
import 'package:bar_de_bordo/models/product.dart';
import 'package:bar_de_bordo/models/sale_product.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class SaleCartNotifier extends ValueNotifier<List<SaleProduct>> {
  SaleCartNotifier() : super([]);

  final Map<String, SaleProduct> _map = {};

  late final CartPriceNotifier cartPriceNotifier = CartPriceNotifier();

  void addProduct(Product product) {
    SaleProduct? saleProduct = value.firstWhereOrNull(
      (element) => element.id == product.id,
    );
    if (saleProduct == null) {
      saleProduct = SaleProduct.fromProduct(product);
      value.add(saleProduct);
      _map[saleProduct.id] = saleProduct;
      cartPriceNotifier.addPrice(product.price);
    } else {
      addQuantity(id: product.id);
    }

    notifyListeners();
  }

  void removeProduct(SaleProduct product) {
    cartPriceNotifier.subtractPrice(_map[product.id]!.totalPrice);
    value.remove(product);
    _map.remove(product.id);
    notifyListeners();
  }

  int addQuantity({required String id, int qnt = 1}) {
    assert(qnt > 0);
    assert(_map.containsKey(id));
    if (qnt <= 0 || !_map.containsKey(id)) return -1;

    cartPriceNotifier.addPrice(_map[id]!.unitPrice * qnt);

    return _map[id]!.addQuantity(qnt);
  }

  int subtractQuantity({required String id, int qnt = 1}) {
    assert(qnt > 0);
    assert(_map.containsKey(id));

    if (qnt <= 0 || !_map.containsKey(id)) return -1;

    final result = _map[id]!.subtractQuantity(qnt);

    if (result == 0) {
      removeProduct(_map[id]!);
      return -1;
    }

    cartPriceNotifier.subtractPrice(_map[id]!.unitPrice * qnt);
    return result;
  }
}

class CartPriceNotifier extends ValueNotifier<Price> {
  CartPriceNotifier() : super(Price());

  void addPrice(Price price) {
    addValue(price.value);
  }

  void addValue(int cents) {
    assert(cents > 0);

    value.value += cents;
    notifyListeners();
  }

  void subtractPrice(Price price) {
    subtractValue(price.value);
  }

  void subtractValue(int cents) {
    assert(cents > 0);

    value.value -= cents;
    notifyListeners();
  }
}
