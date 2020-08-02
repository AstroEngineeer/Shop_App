import 'package:flutter/foundation.dart';

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
