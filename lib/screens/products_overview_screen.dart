import 'package:Shop_App/providers/cart.dart';
import 'package:Shop_App/providers/products.dart';
import 'package:Shop_App/widgets/badge.dart';
import 'package:Shop_App/widgets/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum filter {
  Favorite,
  ShowAll,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    var productContainer = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (filter value) {
              setState(() {
                if (value == filter.Favorite) {
                  productContainer.showFavorite();
                } else {
                  productContainer.showAll();
                }
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Only Favorites"),
                value: filter.Favorite,
              ),
              PopupMenuItem(
                child: Text("Show All"),
                value: filter.ShowAll,
              ),
            ],
            icon: Icon(Icons.more_vert),
          ),
          Consumer<Cart>(
            builder: (context, value, child) {
              return Badge(
                child: child,
                value: value.itemCount.toString(),
              );
            },
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: null,
            ),
          )
        ],
      ),
      body: ProductGrid(),
    );
  }
}
