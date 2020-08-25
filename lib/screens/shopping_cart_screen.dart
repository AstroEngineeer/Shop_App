import 'package:Shop_App/providers/cart.dart' show Cart;
import 'package:Shop_App/providers/order.dart';
import 'package:Shop_App/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingCartScreen extends StatelessWidget {
  static String routeName = "ShoppingCartScreen";

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 23),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                      "₹${cart.totalAmt.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  OrderButton(cart: cart)
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: cart.itemCount,
            itemBuilder: (context, index) => CartItem(
              id: cart.items.values.toList()[index].id,
              title: cart.items.values.toList()[index].title,
              quantity: cart.items.values.toList()[index].quantity,
              price: cart.items.values.toList()[index].price,
              productid: cart.items.keys.toList()[index],
            ),
          ))
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: (isLoading || widget.cart.totalAmt <= 0)
            ? null
            : () async {
                setState(() {
                  isLoading = true;
                });
                await Provider.of<Orders>(context, listen: false).addItem(
                    widget.cart.items.values.toList(), widget.cart.totalAmt);
                setState(() {
                  isLoading = false;
                });
                widget.cart.clear();
              },
        child: isLoading
            ? CircularProgressIndicator()
            : Text(
                "Order Now",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ));
  }
}
