import 'package:Shop_App/providers/cart.dart';
import 'package:Shop_App/providers/products.dart';
import 'package:Shop_App/screens/product_details_screen.dart';
import 'package:Shop_App/screens/products_overview_screen.dart';
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
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.cyan),
        title: "Shop App",
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
        },
      ),
    );
  }
}
