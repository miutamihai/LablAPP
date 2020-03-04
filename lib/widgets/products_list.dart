import 'package:flutter/material.dart';
import 'package:compare_that_price/models/product.dart';
import 'smart_flare_animation.dart';
import 'product_widget.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> with SingleTickerProviderStateMixin {

  final List<Product> _listOfProducts = [
    Product(name: 'Guinness', image: ('assets/images/guinness_can.jpg'),
    price: '2€', description: 'Rich and creamy. Distinctive, Ruby Red colour. Velvety in its finish.'),
    Product(name: 'Carlsberg', image: ('assets/images/carlsberg_can.jpg'),
        price: '2€', description: 'Perfectly balanced Danish Pilsner, wonderfully crisp and refreshing, with a full flavour and a distinctive hoppy aroma.'),
    Product(name: 'Heineken', image: ('assets/images/heineken_can.jpg'),
        price: '2€', description: 'Available in over 192 countries globally, Heineken is Ireland’s most popular lager.'),
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
              style: TextStyle(fontSize: 40, fontFamily: 'Acme', decoration: TextDecoration.none, color: Colors.white70),
            ),
          ),
          backgroundColor: Colors.amber,
          automaticallyImplyLeading: false,
        ),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            ListView.builder(itemBuilder: (_, int index)
            => ProductCard(
              this._listOfProducts[index]
            ),
              itemCount: this._listOfProducts.length,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SmartFlareAnimation('navigate'),
            )
          ],
        )
      ),
    );
  }
}
