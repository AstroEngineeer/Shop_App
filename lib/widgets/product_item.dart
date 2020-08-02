import 'package:Shop_App/providers/product.dart';
import 'package:Shop_App/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var item = Provider.of<Product>(context, listen: false);
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
          leading: Consumer<Product>(
            builder: (context, value, _) => IconButton(
              icon: Icon(
                value.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.indigo,
              ),
              onPressed: () {
                value.toggleFavorite();
              },
            ),
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
