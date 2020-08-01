import 'package:Shop_App/screens/products_overview_screen.dart';
import 'package:flutter/material.dart';

main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.cyan),
      title: "Shop App",
      home: ProductsOverviewScreen(),
    );
  }
}
