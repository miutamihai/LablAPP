import 'package:flutter/foundation.dart';

class Product {
  final String name;
  final String brand;
  final double price;
  final String currency;
  final String size;

  Product({
    @required this.name,
    this.brand,
    @required this.price,
    this.currency,
    @required this.size,
  });
}
