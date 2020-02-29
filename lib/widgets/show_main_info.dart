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
        setState((){});
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
            index < stars.roundToDouble().toInt() ? Icons.star : Icons.star_border,
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
            style: TextStyle(fontSize: 35, color: themeColor),
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
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image(
                      image: comments[index].profileImage,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "${comments[index].username}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontStyle: FontStyle.italic),
                      ),
                      TextSpan(text: "\n"),
                      TextSpan(
                        text: "${comments[index].comment}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      )
                    ]),
                  )
                ],
              ),
              Divider(
                height: 20,
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
      Comment(AssetImage("assets/images/birra_moretti-330ml-4mp.jpg"), "User1",
          "Nice Beer Bros"),
      Comment(AssetImage("assets/images/birra_moretti-330ml-4mp.jpg"), "User2",
          "I didn't like it"),
      Comment(AssetImage("assets/images/birra_moretti-330ml-4mp.jpg"), "User3",
          "Where can I buy it cheaper?"),
      Comment(AssetImage("assets/images/birra_moretti-330ml-4mp.jpg"), "User1",
          "Nice Beer Bros"),
      Comment(AssetImage("assets/images/birra_moretti-330ml-4mp.jpg"), "User2",
          "I didn't like it"),
      Comment(AssetImage("assets/images/birra_moretti-330ml-4mp.jpg"), "User3",
          "Where can I buy it cheaper?"),
      Comment(AssetImage("assets/images/birra_moretti-330ml-4mp.jpg"), "User1",
          "Nice Beer Bros"),
      Comment(AssetImage("assets/images/birra_moretti-330ml-4mp.jpg"), "User2",
          "I didn't like it"),
      Comment(AssetImage("assets/images/birra_moretti-330ml-4mp.jpg"), "User3",
          "Where can I buy it cheaper?"),
      Comment(AssetImage("assets/images/birra_moretti-330ml-4mp.jpg"), "User1",
          "Nice Beer Bros"),
      Comment(AssetImage("assets/images/birra_moretti-330ml-4mp.jpg"), "User2",
          "I didn't like it"),
      Comment(AssetImage("assets/images/birra_moretti-330ml-4mp.jpg"), "User3",
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
                color: Colors.grey[300],
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 30),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "            $beerLabel's \n"+
                  "Country average price is:\n"+
                  "                   $beerPrice",
                  style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
                )),
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: _createCommentsView(comments))
          ]),
        ),
      ),
    );
  }
}
