import 'package:bar_de_bordo/models/product.dart';
import 'package:bar_de_bordo/screens/stock/add_product_screen.dart';
import 'package:bar_de_bordo/models/product_collection.dart';
import 'package:bar_de_bordo/services/firebase/entity/firestore_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  const ProductTile(this.product, {super.key});

  final Product product;

  void edit(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddProductScreen(product: product),
      ),
    );
  }

  void delete() {
    // data.delete();
    // FirestoreCollection.getInstance<ProductCollection>().deleteItem(product);
    product.delete();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      leadingAndTrailingTextStyle: Theme.of(context).textTheme.bodyMedium,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(product.price.toString()),
          SizedBox(width: 16),
          IconButton(onPressed: () => edit(context), icon: Icon(Icons.edit)),
          IconButton(onPressed: delete, icon: Icon(Icons.delete)),
        ],
      ),
    );
  }
}
