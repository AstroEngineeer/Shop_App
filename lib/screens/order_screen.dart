import 'package:Shop_App/providers/order.dart' show Orders;
import 'package:Shop_App/widgets/app_drawer.dart';
import 'package:Shop_App/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  static String routeName = "OrderScreen";
  @override
  Widget build(BuildContext context) {
    var orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      drawer: AppDrawer(),
      body: Card(
        margin: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: orders.items.length,
          itemBuilder: (context, index) => OrderItem(orders.items[index]),
        ),
      ),
    );
  }
}
