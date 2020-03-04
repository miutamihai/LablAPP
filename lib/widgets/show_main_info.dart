import 'dart:convert';

import 'package:compare_that_price/models/comment.dart';
import 'package:flutter/material.dart';

class ShowMainInfo extends StatefulWidget {
  final finalResponse;

  ShowMainInfo(this.finalResponse);

  @override
  _ShowMainInfoState createState() => _ShowMainInfoState(finalResponse);
}

class _ShowMainInfoState extends State<ShowMainInfo>
    with SingleTickerProviderStateMixin {
  double maxTop = 500;
  double minTop = 0;

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    animation = Tween<double>(begin: maxTop, end: minTop).animate(controller)
      ..addListener(() {
        setState(() {});
      });
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
          getStars(rating),
          Container(
            width: 10,
          ),
          Text(
            "$rating Stars",
            style: TextStyle(fontSize: 35, color: Colors.amber, decoration: TextDecoration.none),
          )
        ],
      ),
    );
  }

  _createCommentsView(List<Comment> comments) {
    return ListView.builder(
      itemCount: comments.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 25),
                child: CircleAvatar(
                  minRadius: 30,
                  maxRadius: 30,
                  backgroundImage: comments[index].profileImage,
                  backgroundColor: Colors.white70,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Card(
                  margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
                  elevation: 10,
                  color: Colors.amberAccent,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: "${comments[index].username}",
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 30,
                              ),
                            ),
                            TextSpan(text: "\n"),
                            TextSpan(
                              text: "${comments[index].comment}",
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 20,
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

  final rating = 3.7; //TODO: Change it to make it variable

  @override
  Widget build(BuildContext context) {
    var jsonString = jsonDecode(finalResponse);

    String beerLabel = jsonString['label'];
    String beerPrice = jsonString['price'];

    List<Comment> comments = [
      Comment(AssetImage("assets/images/login_clipart.png"), "User1",
          "Nice Beer Bros"),
      Comment(AssetImage("assets/images/login_clipart.png"), "User2",
          "I didn't like it"),
      Comment(AssetImage("assets/images/login_clipart.png"), "User3",
          "Where can I buy it cheaper?"),
      Comment(AssetImage("assets/images/login_clipart.png"), "User1",
          "Nice Beer Bros"),
      Comment(AssetImage("assets/images/login_clipart.png"), "User2",
          "I didn't like it"),
      Comment(AssetImage("assets/images/login_clipart.png"), "User3",
          "Where can I buy it cheaper?"),
      Comment(AssetImage("assets/images/login_clipart.png"), "User1",
          "Nice Beer Bros"),
      Comment(AssetImage("assets/images/login_clipart.png"), "User2",
          "I didn't like it"),
      Comment(AssetImage("assets/images/login_clipart.png"), "User3",
          "Where can I buy it cheaper?"),
      Comment(AssetImage("assets/images/login_clipart.png"), "User1",
          "Nice Beer Bros"),
      Comment(AssetImage("assets/images/login_clipart.png"), "User2",
          "I didn't like it"),
      Comment(AssetImage("assets/images/login_clipart.png"), "User3",
          "Where can I buy it cheaper?"),
    ];

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
                    color: Colors.amberAccent[600],
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
                  child: _createCommentsView(comments)),
            )
          ]),
        ),
      ),
    );
  }
}
