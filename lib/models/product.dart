import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Product {
  final String name;
  String image;
  String price;
  String description;
  String reviews;

  Product({
    @required this.name,
    this.image,
    this.price,
    this.description,
    this.reviews

  });
}
