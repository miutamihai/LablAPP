import 'package:flutter/material.dart';
import 'package:labl_app/models/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:labl_app/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:slimy_card/slimy_card.dart';
import 'beer_description.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard(this.product);
  @override
  _ProductCardState createState() => _ProductCardState(this.product);
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  DocumentReference _document;
  Widget beerDescription;
  Product product;
  var _firestoreService;
  String image =
      'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.iconfinder.com%2Ficons%2F3273769%2Fempty_image_picture_placeholder_icon&psig=AOvVaw2uSARERdJv82tA4y2fZjjp&ust=1583538146682000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCMifqbnBhOgCFQAAAAAdAAAAABAD';
  _ProductCardState(product) {
    this.product = product;
  }
   

  Future<void> loadImageFromStorage() async {
    await FirebaseStorage.instance
        .ref()
        .child(product.image)
        .getDownloadURL()
        .then((value) {
      print('await done');
      setState(() {
        image = value.toString();
        print(image);
        beerDescription = BeerDescription(_document, product.name, image);
      });
    });
  }

  Future<void> getBeerReview() async {
    await _document.get().then((value) {
      setState(() {
        print('got beer reviews');
        product.reviews = value['Average rating'].toString();
      });
    });
  }

  final headerTextStyle = TextStyle(
      color: Colors.grey[800], fontSize: 18.0, fontWeight: FontWeight.w600);

  final regularTextStyle = TextStyle(
      color: Colors.grey[800], fontSize: 10, fontWeight: FontWeight.w400);

  final subHeaderTextStyle = TextStyle(
      fontSize: 12.0, color: Colors.grey[800], fontWeight: FontWeight.w400);

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    loadImageFromStorage();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies(){
    setState(() {
      _firestoreService= Provider.of<FireStoreService>(context);
      _document = _firestoreService.Beers.document(product.name);
      getBeerReview();
      beerDescription = BeerDescription(_document, product.name, product.image);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final beerThumbnail = new Container(
      alignment: new FractionalOffset(0.0, 0.5),
      margin: const EdgeInsets.only(left: 24.0),
      child: new Hero(
        tag: '${product.name}',
        child: new CircleAvatar(
          backgroundImage: NetworkImage(image),
          minRadius: 60,
          maxRadius: 60,
        ),
      ),
    );
    final beerCard = new Container(
      margin: const EdgeInsets.only(left: 72.0, right: 24.0),
      decoration: new BoxDecoration(
        color: Colors.amber[50],
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
              color: Colors.black,
              blurRadius: 10.0,
              offset: new Offset(0.0, 10.0))
        ],
      ),
      child: new Container(
        margin: const EdgeInsets.only(top: 16.0, left: 72.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(product.name, style: headerTextStyle),
            new Container(
                color: Colors.amber[50],
                width: 24.0,
                height: 1.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0)),
            new Row(
              children: <Widget>[
                new Icon(Icons.attach_money, size: 30, color: Colors.amber),
                new Text(product.price, style: headerTextStyle),
                new Container(width: 10),
                new Icon(
                  Icons.favorite,
                  size: 30,
                  color: Colors.amber,
                ),
                new Text(
                  product.reviews,
                  style: headerTextStyle,
                )
              ],
            )
          ],
        ),
      ),
    );

    return SlimyCard(
      color: Colors.amberAccent,
      topCardHeight: 150,
      topCardWidget: Container(
        height: 150,
        child: Stack(
          children: <Widget>[beerCard, beerThumbnail],
        ),
      ),
      bottomCardWidget: beerDescription,
      bottomCardHeight: 200,
    );
  }
}
