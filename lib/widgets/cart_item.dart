import 'package:Shop_App/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final id;
  final productid;
  final title;
  final price;
  final quantity;

  CartItem({this.id, this.productid, this.price, this.quantity, this.title});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(productid),
      direction: DismissDirection.endToStart,
      onDismissed: (dismissDirection) {
        Provider.of<Cart>(context, listen: false).removeItem(productid);
      },
      background: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Icon(
            Icons.delete,
            size: 40,
          ),
        ),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        elevation: 8,
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.all(3.0),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(
                    child: Text(
                  "₹$price",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                )),
              ),
            ),
          ),
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          trailing: Text(
            "x$quantity",
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
