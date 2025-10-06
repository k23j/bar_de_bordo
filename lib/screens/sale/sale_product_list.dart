import 'package:bar_de_bordo/models/product.dart';
import 'package:flutter/material.dart';

class SaleProductList extends StatelessWidget {
  const SaleProductList({
    required this.productList,
    required this.addProduct,
    super.key,
  });

  final List<Product> productList;

  final Function(Product product) addProduct;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: productList.length,
      itemBuilder: (context, index) {
        return ProductOnStoreTile(
          product: productList[index],
          addProduct: addProduct,
        );
      },
    );
  }
}

class ProductOnStoreTile extends StatelessWidget {
  const ProductOnStoreTile({
    required this.product,
    required this.addProduct,
    super.key,
  });

  final Product product;

  final Function(Product product) addProduct;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      trailing: IconButton(
        onPressed: () => addProduct(product),
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(4),
            ),
          ),
          backgroundColor: WidgetStatePropertyAll(
            Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
        icon: Icon(Icons.add),
      ),
    );
  }
}
