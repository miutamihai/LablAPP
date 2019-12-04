import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';

import '../models/product.dart';

class ProductsList extends StatelessWidget {
  final List<Product> _products = [
    Product(
      name: 'Tyskie',
      price: 2,
      size: '500 ml'
    ),
    Product(
      name: 'Tyskie',
      price: 2,
      size: '500 ml'
    ),
    Product(
      name: 'Tyskie',
      price: 2,
      size: '500 ml'
    ),
    Product(
      name: 'Tyskie',
      price: 2,
      size: '500 ml'
    ),
    Product(
      name: 'Tyskie',
      price: 2,
      size: '500 ml'
    ),
    Product(
      name: 'Tyskie',
      price: 2,
      size: '500 ml'
    ),
    Product(
      name: 'Tyskie',
      price: 2,
      size: '500 ml'
    ),
    Product(
      name: 'Tyskie',
      price: 2,
      size: '500 ml'
    ),
    Product(
      name: 'Tyskie',
      price: 2,
      size: '500 ml'
    ),
    Product(
      name: 'Tyskie',
      price: 2,
      size: '500 ml'
    ),
  ];

  //ProductsList(this.products);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Card(
          child: Row(
            children: [
              Container(
                height: 100,
                child: Image.asset(
                  'assets/images/emoticon-heart-4mp-free.png',
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      _products[index].name,
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        _products[index].size,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '\$${_products[index].price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
      itemCount: _products.length,
    );
  }
}
