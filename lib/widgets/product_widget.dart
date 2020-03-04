import 'package:flutter/material.dart';
import 'package:compare_that_price/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product _product;

  ProductCard(this._product);

  final headerTextStyle = TextStyle(
      color: Colors.grey[800], fontSize: 18.0, fontWeight: FontWeight.w600);

  final regularTextStyle = TextStyle(
      color: Colors.grey[800], fontSize: 10, fontWeight: FontWeight.w400);

  final subHeaderTextStyle = TextStyle(
      fontSize: 12.0, color: Colors.grey[800], fontWeight: FontWeight.w400);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: CircleAvatar(
                minRadius: 50,
                maxRadius: 50,
                backgroundImage: AssetImage(_product.image)
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Card(
              margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
              elevation: 10,
              color: Colors.amberAccent,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(height: 4.0),
                  new Text(
                    _product.name + ' ' + _product.price,
                    style: headerTextStyle,
                  ),
                  new Container(
                    alignment: Alignment.center,
                    margin: new EdgeInsets.symmetric(vertical: 8.0),
                    color: Colors.amber[300],
                    child: Text(
                      _product.description,
                      style: regularTextStyle,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
