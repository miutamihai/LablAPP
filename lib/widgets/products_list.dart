import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';

import '../models/product.dart';

class ProductsList extends StatelessWidget {
  final List<Product> _products = [
    Product(
      name: 'Tyskie',
      image: 'assets/images/tyskie_jsne-500ml.jpg',
      price: 2,
      size: '500 ml'
    ),
    Product(
      name: 'Budweiser',
      image: 'assets/images/budweiser-can-440ml.jpg',
      price: 2,
      size: '440 ml'
    ),
    Product(
      name: 'Corona Light',
      image: 'assets/images/corona_light-335ml.jpg',
      price: 2,
      size: '335 ml'
    ),
    Product(
      name: 'Heineken Original',
      image: 'assets/images/heineken_original-330ml.jpg',
      price: 2,
      size: '330 ml'
    ),
    Product(
      name: 'Rockshore',
      image: 'assets/images/rockshore-can-500ml.jpg',
      price: 2,
      size: '500 ml'
    ),
    Product(
      name: 'Hop House 13',
      image: 'assets/images/hop_house_13-can-500ml.jpg',
      price: 2,
      size: '500 ml'
    ),
    Product(
      name: 'Birra Moretti',
      image: 'assets/images/birra_moretti-330ml1.png',
      price: 2,
      size: '330 ml'
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
                height: 120,
                padding: EdgeInsets.all(10),
                child: Image.asset(
                  'assets/images/emoticon-heart-4mp-free.png',
                  //_products[index].image,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      _products[index].name,
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
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
