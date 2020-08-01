import 'package:flutter/foundation.dart';

class Product {
  final id;
  final title;
  final imageUrl;
  final description;
  final price;

  Product(
      {@required this.description,
      @required this.id,
      @required this.imageUrl,
      @required this.price,
      @required this.title});
}
