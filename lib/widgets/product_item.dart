import 'package:Shop_App/providers/auth.dart';
import 'package:Shop_App/providers/cart.dart';
import 'package:Shop_App/providers/products.dart';
import 'package:Shop_App/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var item = Provider.of<Product>(context, listen: false);
    var cart = Provider.of<Cart>(context, listen: false);
    var auth = Provider.of<Auth>(context, listen: false);
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
                value.toggleFavorite(auth.token, auth.userId);
              },
            ),
          ),
          title: Text(item.title),
          trailing: IconButton(
            icon: Icon(
              Icons.add_shopping_cart,
              color: Colors.indigo,
            ),
            onPressed: () {
              cart.addItem(item.id, item.price, item.title);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Item added to cart!"),
                action: SnackBarAction(
                    label: "Undo",
                    onPressed: () {
                      cart.removeItem(item.id);
                    }),
              ));
            },
          ),
        ),
      ),
    );
  }
}
