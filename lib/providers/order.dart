import 'package:Shop_App/providers/cart.dart';
import 'package:flutter/material.dart';

class OrderItem {
  final id;
  final price;
  final List<CartItem> products;
  final DateTime date;

  OrderItem(
      {@required this.id,
      @required this.date,
      @required this.price,
      @required this.products});
}

class Orders with ChangeNotifier {
  List<OrderItem> _items = [];

  List<OrderItem> get items {
    return [..._items];
  }

  void addItem(List<CartItem> i, double total) {
    _items.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            price: total,
            date: DateTime.now(),
            products: i));
    notifyListeners();
  }
}
