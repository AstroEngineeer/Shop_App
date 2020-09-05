import 'package:Shop_App/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  String authToken;
  String userId;
  Orders(this.authToken, this._items, this.userId);

  List<OrderItem> get items {
    return [..._items];
  }

  Future<void> fetchOrders() async {
    final url =
        "https://shop-app-flutter-459e5.firebaseio.com/orders/$userId.json?auth=$authToken";
    var response = await http.get(url);
    var fetchedOrders = json.decode(response.body) as Map<String, dynamic>;
    if (fetchedOrders == null) {
      return;
    }
    //print(json.decode(response.body));
    List<OrderItem> orders = [];
    fetchedOrders.forEach((key, value) {
      //print(value['Date']);
      orders.add(
        OrderItem(
          id: key,
          date: DateTime.parse(value['Date']),
          price: value['Price'],
          products: (value['Items'] as List<dynamic>)
              .map(
                (e) => CartItem(
                    id: e['id'],
                    title: e['title'],
                    quantity: e['quantity'],
                    price: e['price']),
              )
              .toList(),
        ),
      );
    });
    _items = orders;
    notifyListeners();
  }

  Future<void> addItem(List<CartItem> i, double total) async {
    var timeStamp = DateTime.now();
    final url =
        "https://shop-app-flutter-459e5.firebaseio.com/orders$userId.json?auth=$authToken";
    var response = await http.post(url,
        body: json.encode({
          "Date": timeStamp.toIso8601String(),
          "Price": total,
          "Items": i
              .map((e) => {
                    "id": e.id,
                    "price": e.price,
                    "quantity": e.quantity,
                    "title": e.title
                  })
              .toList()
        }));
    _items.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            price: total,
            date: timeStamp,
            products: i));
    notifyListeners();
  }
}
