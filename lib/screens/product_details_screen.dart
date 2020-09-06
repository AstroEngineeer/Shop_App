import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Shop_App/providers/products.dart';

class ProductDetailsScreen extends StatelessWidget {
  static String routeName = "ProductDetailsScreen";

  @override
  Widget build(BuildContext context) {
    final productID = ModalRoute.of(context).settings.arguments as String;
    final item = Provider.of<Products>(context).getById(productID);

    return Scaffold(
      appBar: AppBar(
        title: Text(item.title + " - ₹" + item.price.toString()),
      ),
      body: Column(
        children: <Widget>[
          Hero(
            tag: item.id,
            child: Image.network(
              item.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30),
          ),
          Card(
            child: Text(
              item.description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
