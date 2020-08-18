import 'package:Shop_App/providers/products.dart';
import 'package:Shop_App/widgets/app_drawer.dart';
import 'package:Shop_App/widgets/user_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  static String routeName = "userproductscreen";

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your products"),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              })
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Column(
              children: [
                UserProductItem(
                    productData.items[index].id,
                    productData.items[index].title,
                    productData.items[index].imageUrl),
                Divider(),
              ],
            );
          },
          itemCount: productData.items.length,
        ),
      ),
    );
  }
}
