import 'package:Shop_App/models/HttpException.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final id;
  final title;
  final imageUrl;
  final description;
  final price;
  bool isFavorite;

  Product(
      {@required this.description,
      @required this.id,
      @required this.imageUrl,
      @required this.price,
      @required this.title,
      this.isFavorite = false});

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}

class Products with ChangeNotifier {
  List<Product> items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  bool showFavoriteOnly = false;

  void showFavorite() {
    showFavoriteOnly = true;
  }

  void showAll() {
    showFavoriteOnly = false;
  }

  List<Product> get getAllProducts {
    return [...items];
  }

  List<Product> get getFavoriteProducts {
    return items.where((element) => element.isFavorite == true).toList();
  }

  Product getById(String id) {
    return items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchProducts() async {
    const url = "https://shop-app-flutter-459e5.firebaseio.com/products.json";
    try {
      var response = await http.get(url);
      var fetchedProduct = json.decode(response.body) as Map<String, dynamic>;
      //print(fetchedProduct);
      List<Product> products = [];
      fetchedProduct.forEach((key, value) {
        products.add(
          Product(
              description: value['Description'],
              id: key,
              imageUrl: value['ImageUrl'],
              price: value['Price'],
              title: value['Title'],
              isFavorite: value['isFavorite']),
        );
      });
      items = products;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product p) async {
    const url = "https://shop-app-flutter-459e5.firebaseio.com/products.json";
    try {
      var response = await http.post(
        url,
        body: json.encode({
          "Title": p.title,
          "Description": p.description,
          "Price": p.price,
          "ImageUrl": p.imageUrl,
          'isFavorite': p.isFavorite
        }),
      );
      var product = Product(
          description: p.description,
          id: json.decode(response.body)['name'],
          imageUrl: p.imageUrl,
          price: p.price,
          title: p.title);
      items.add(product);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product p) async {
    final index = items.indexWhere((element) => element.id == id);
    final url =
        "https://shop-app-flutter-459e5.firebaseio.com/products/$id.json";

    await http.patch(
      url,
      body: json.encode({
        "Title": p.title,
        "Description": p.description,
        "Price": p.price,
        "ImageUrl": p.imageUrl,
        'isFavorite': p.isFavorite
      }),
    );
    items[index] = p;
    notifyListeners();
  }

  Future<void> removeProduct(String id) async {
    final url =
        "https://shop-app-flutter-459e5.firebaseio.com/products/$id.json";
    //final index = items.indexWhere((element) => element.id == id);
    //final removedProduct = items[index];
    var response = await http.delete(url);
    if (response.statusCode >= 400) {
      throw HttpException("Could not delete!");
    }
    items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
