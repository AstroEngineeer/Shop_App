import 'package:Shop_App/models/product.dart';
import 'package:Shop_App/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final Product item;
  ProductItem(this.item);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductDetailsScreen.routeName, arguments: item.id);
          },
          child: Image.network(item.imageUrl),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(
              Icons.favorite,
              color: Colors.indigo,
            ),
            onPressed: null,
          ),
          title: Text(item.title),
          trailing: IconButton(
            icon: Icon(
              Icons.add_shopping_cart,
              color: Colors.indigo,
            ),
            onPressed: null,
          ),
        ),
      ),
    );
  }
}
