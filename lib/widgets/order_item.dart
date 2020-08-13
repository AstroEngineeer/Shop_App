import 'dart:math';

import 'package:Shop_App/providers/order.dart' as o;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class OrderItem extends StatefulWidget {
  final o.OrderItem item;

  OrderItem(this.item);
  var _exapanded = false;
  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 8,
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text("₹${widget.item.price.toString()}"),
            subtitle: Text(
              DateFormat("dd/MM/yyyy hh:mm").format(widget.item.date),
            ),
            trailing: IconButton(
                icon: Icon(
                    widget._exapanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    widget._exapanded = !widget._exapanded;
                  });
                }),
          ),
          if (widget._exapanded)
            Container(
              height: min(widget.item.products.length * 10 + 50.0, 180),
              child: ListView.builder(
                itemCount: widget.item.products.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.item.products[index].title),
                    trailing: Text(
                        "${widget.item.products[index].price}x${widget.item.products[index].quantity}"),
                  );
                },
              ),
            )
        ],
      ),
    );
  }
}
