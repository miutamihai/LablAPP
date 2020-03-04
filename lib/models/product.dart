import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Product {
  final String name;
  final String image;
  final String price;
  final String description;

  Product({
    @required this.name,
    @required this.image,
    @required this.price,
    @required this.description,
  });
}
