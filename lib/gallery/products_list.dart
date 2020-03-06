import 'package:flutter/material.dart';
import 'package:labl_app/gallery/product_widget.dart';
import 'package:labl_app/navigation/smart_flare_animation.dart';
import 'package:labl_app/models/product.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList>
    with SingleTickerProviderStateMixin {
  final List<Product> _listOfProducts = [
    Product(
        name: 'Guinness',
        image: ("beers/guinness_can.jpg"),
        price: '2€',
        description: 'test',
        reviews: ''),
    Product(
        name: 'Carlsberg',
        image: ("beers/carlsberg_can.jpg"),
        price: '2€',
        description: 'test',
        reviews: ''),
    Product(
        name: 'Heineken',
        image: ("beers/heineken_can.jpg"),
        price: '2€',
        description: 'test',
        reviews: ''),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44),
        child: AppBar(
          centerTitle: true,
          title: Hero(
            tag: 'app_title',
            child: Text(
              '~LABL~',
              style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'Acme',
                  decoration: TextDecoration.none,
                  color: Colors.white70),
            ),
          ),
          backgroundColor: Colors.amber,
          automaticallyImplyLeading: false,
        ),
      ),
      body: Container(
          child: Stack(
        children: <Widget>[
          ListView.builder(
            itemBuilder: (_, int index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: index == this._listOfProducts.length
                  ? Container(
                      height: 100,
                    )
                  : ProductCard(this._listOfProducts[index]),
            ),
            itemCount: this._listOfProducts.length + 1,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SmartFlareAnimation('navigate'),
          )
        ],
      )),
    );
  }
}
