import 'package:Shop_App/providers/cart.dart';
import 'package:Shop_App/providers/order.dart';
import 'package:Shop_App/providers/products.dart';
import 'package:Shop_App/screens/edit_product_screen.dart';
import 'package:Shop_App/screens/order_screen.dart';
import 'package:Shop_App/screens/product_details_screen.dart';
import 'package:Shop_App/screens/products_overview_screen.dart';
import 'package:Shop_App/screens/shopping_cart_screen.dart';
import 'package:Shop_App/screens/user_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.cyan),
        title: "Shop App",
        routes: {
          "/": (ctx) => ProductsOverviewScreen(),
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
          ShoppingCartScreen.routeName: (ctx) => ShoppingCartScreen(),
          OrderScreen.routeName: (ctx) => OrderScreen(),
          UserProductScreen.routeName: (ctx) => UserProductScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
