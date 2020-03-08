import 'dart:convert';

import 'package:labl_app/models/comment.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowMainInfo extends StatefulWidget {
  final finalResponse;

  ShowMainInfo(this.finalResponse);

  @override
  _ShowMainInfoState createState() => _ShowMainInfoState(finalResponse);
}

class _ShowMainInfoState extends State<ShowMainInfo>
    with SingleTickerProviderStateMixin {
  String beerLabel;
  String beerPrice;
  double maxTop = 500;
  double minTop = 0;
  double rating = 3.7;
  DocumentSnapshot firebase;
  DocumentReference _document;
  List<Comment> comments = [
    Comment('', "User1",
        "Nice Beer Bros"),
    Comment('', "User2",
        "I didn't like it"),
    Comment('', "User3",
        "Where can I buy it cheaper?"),
    Comment('', "User1",
        "Nice Beer Bros"),
    Comment('', "User2",
        "I didn't like it"),
    Comment('', "User3",
        "Where can I buy it cheaper?"),
    Comment('', "User1",
        "Nice Beer Bros"),
  ];
  Animation<double> animation;
  AnimationController controller;

  Future<void> getComments() async {
    await _document.get().then((value) {
      setState(() {
        rating = value['Average rating'].toDouble();
        print('added rating');
        comments = List<Comment>.from(value['Comments'].map(
            (d) => Comment.fromMap(d)
        ));
      });
    });
  }

  @override
  void initState() {
    print(finalResponse);
    var jsonString = jsonDecode(finalResponse);

    beerLabel = jsonString['label'];
    beerPrice = jsonString['price'];
    controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    animation = Tween<double>(begin: maxTop, end: minTop).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    _document = Firestore.instance.collection('Beers').document(beerLabel);
    getComments();
    super.initState();
  }
  
  @override
  void dispose() {
    super.dispose();
  }

  final finalResponse;

  _ShowMainInfoState(this.finalResponse);

  Widget getStars(double stars) {
    return Container(
      color: Colors.grey[300],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          return Icon(
            index < stars.roundToDouble().toInt()
                ? Icons.star
                : Icons.star_border,
            color: Colors.deepOrange,
            size: 45,
          );
        }),
      ),
    );
  }

  Widget showStarsAndRating(Color themeColor) {
    return Container(
      color: Colors.grey[300],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 10,
          ),
          Text(
            "$rating Stars",
            style: TextStyle(fontSize: 35, color: Colors.grey[800], decoration: TextDecoration.none, fontFamily: 'Acme'),
          ),
          getStars(rating),
        ],
      ),
    );
  }

  void _listener() {
    setState(() {
      print('profile picture changed');
    });
  }


  _createCommentsView() {
    return ListView.builder(
      itemCount: comments.length,
      itemBuilder: (BuildContext context, int index) {
        comments[index].addListener(_listener, ['profile image arrived']);
        return Container(
          decoration: BoxDecoration(
            color: Colors.amber[300],
            shape: BoxShape.rectangle,
            borderRadius: new BorderRadius.circular(40),
            boxShadow: <BoxShadow>[
              new BoxShadow(color: Colors.black,
                  blurRadius: 10.0,
                  offset: new Offset(0.0, 10.0))
            ],
          ),
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 25, left: 25),
                child: CircleAvatar(
                  minRadius: 30,
                  maxRadius: 30,
                  backgroundImage: NetworkImage(comments[index].profileImage),
                  backgroundColor: Colors.white70,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10, left: 30),
                child: Card(
                  margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
                  elevation: 10,
                  color: Colors.amber[50],
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: "${comments[index].username}" + " " + "${comments[index].madeIn}",
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 30,
                                fontFamily: 'Acme'
                              ),
                            ),
                            TextSpan(text: "\n"),
                            TextSpan(
                              text: "${comments[index].comment}",
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 20,
                                fontFamily: 'Acme'
                              ),
                            )
                          ]),
                        )
                      ],
                    ),
                  )
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _drawerHandler() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 25),
      height: 3,
      width: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.black),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Positioned(
      top: animation.value,
      left: 0,
      child: GestureDetector(
        onTap: () {
          controller.isCompleted ? controller.reverse() : controller.forward();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            color: Colors.grey[300],
          ),
          child: Column(children: <Widget>[
            _drawerHandler(),
            showStarsAndRating(Theme.of(context).primaryColor),
            Container(
                color: Colors.amberAccent,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Card(
                    margin: new EdgeInsets.all(10),
                    elevation: 10,
                    color: Colors.amber[50],
                    child: Text(
                    "Ireland's average price for a $beerLabel is $beerPrice",
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 18
                    ),
                  )
                )),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Align(
                  alignment: Alignment.center,
                  child: _createCommentsView()),
            )
          ]),
        ),
      ),
    );
  }
}
