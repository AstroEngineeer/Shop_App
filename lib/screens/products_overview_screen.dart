import 'package:Shop_App/providers/cart.dart';
import 'package:Shop_App/providers/products.dart';
import 'package:Shop_App/screens/shopping_cart_screen.dart';
import 'package:Shop_App/widgets/app_drawer.dart';
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
  var _init = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_init) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

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
              onPressed: () {
                Navigator.of(context).pushNamed(ShoppingCartScreen.routeName);
              },
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductGrid(),
    );
  }
}
