import 'dart:convert';
import 'package:labl_app/models/comment.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:labl_app/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'make_comment_widget.dart';
import 'package:alpha2_countries/alpha2_countries.dart';

class ShowMainInfo extends StatefulWidget {
  final finalResponse;
  final String country;

  ShowMainInfo(this.finalResponse, this.country);

  @override
  _ShowMainInfoState createState() =>
      _ShowMainInfoState(finalResponse, country);
}

class _ShowMainInfoState extends State<ShowMainInfo>
    with TickerProviderStateMixin {
  String beerLabel;
  String beerPrice;
  String country;
  double maxTop = 500;
  double minTop = 30;
  double rating = 3.7;
  double exchangeRate = 1.0;
  FirebaseAuth _auth = FirebaseAuth.instance;
  var _firestoreService;
  DocumentReference _document;
  DocumentReference _userData;
  List<Comment> comments = [];
  Animation<double> animation;
  AnimationController controller;
  Widget _makeCommentWidget = Container();

  void callSetStateFromChild(){
    widget.createState();
  }

  Future<void> getComments() async {
    await _document.get().then((value) {
      setState(() {
        rating = value['Average rating'].toDouble();
        print('added rating');
        comments = List<Comment>.from(
            value['Comments'].map((d) => Comment.fromMap(d)));
        print('Comment array of length ${comments.length} as passed');
        _makeCommentWidget = MakeCommentWidget(
            _userData, getISOCodeFromName(country), _document, comments, this.callSetStateFromChild);
      });
    });
  }

  String getISOCodeFromName(String _countryName) {
    return Countries().resolveCode(_countryName);
  }

  Future<void> getDollarToEuroRate() async {
    var uri = Uri.parse(
        'https://api.exchangeratesapi.io/latest?base=USD&symbols=EUR');
    var request = http.Request('GET', uri);
    var response = await request.send();
    var finalResult = await response.stream.bytesToString();
    print(finalResult);
    var jsonString = jsonDecode(finalResult);
    print(jsonString);
    double rate = jsonString['rates']['EUR'];
    print('got euro rate of ${rate}');
    setState(() {
      exchangeRate = rate;
      beerPrice = '€' +
          (double.parse(beerPrice.substring(1)) * exchangeRate)
              .toStringAsFixed(1);
    });
  }

  Future<void> checkCurrencyExchange() async {
    await FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        _userData = _firestoreService.Users.document(user.email);
        _userData.get().then((userData) {
          String _prefferedCurrency = userData['Preffered currency'];
          if (_prefferedCurrency == 'Euros') {
            getDollarToEuroRate();
          }
        });
      });
    });
  }

  @override
  void initState() {
    print(finalResponse);
    var jsonString = jsonDecode(finalResponse);
    beerLabel = jsonString['label'];
    beerPrice = jsonString['price'];
    print(beerPrice);
    controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    animation = Tween<double>(begin: maxTop, end: minTop).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      _firestoreService = Provider.of<FireStoreService>(context);
      _document = _firestoreService.Beers.document(beerLabel);
      getComments();
      checkCurrencyExchange();
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final finalResponse;

  _ShowMainInfoState(this.finalResponse, String _country) {
    this.country = _country;
  }

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
        ));
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
            style: TextStyle(
                fontSize: 35,
                color: Colors.grey[800],
                decoration: TextDecoration.none,
                fontFamily: 'Acme'),
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
    String _emoji(String country) {
      int flagOffset = 0x1F1E6;
      int asciiOffset = 0x41;

      int firstChar = country.codeUnitAt(0) - asciiOffset + flagOffset;
      int secondChar = country.codeUnitAt(1) - asciiOffset + flagOffset;

      String emoji =
          String.fromCharCode(firstChar) + String.fromCharCode(secondChar);
      return emoji;
    }

    return ListView.builder(
      itemCount: comments.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index < comments.length) {
          comments[index].addListener(_listener, ['profile image arrived']);
        }
        return index == comments.length
            ? Container(
                height: 400,
              )
            : Container(
                decoration: BoxDecoration(
                  color: Colors.amber[300],
                  shape: BoxShape.rectangle,
                  borderRadius: new BorderRadius.circular(40),
                  boxShadow: <BoxShadow>[
                    new BoxShadow(
                        color: Colors.black,
                        blurRadius: 10.0,
                        offset: new Offset(0.0, 10.0))
                  ],
                ),
                margin:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Stack(
                  fit: StackFit.loose,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 25, left: 25),
                      child: CircleAvatar(
                        minRadius: 30,
                        maxRadius: 30,
                        backgroundImage:
                            NetworkImage(comments[index].profileImage),
                        backgroundColor: Colors.white70,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10, left: 30),
                      child: Card(
                          margin:
                              new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
                          elevation: 10,
                          color: Colors.amber[50],
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
                                          fontFamily: 'Acme'),
                                    ),
                                    TextSpan(
                                        text: "   in   ",
                                        style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 20,
                                            fontFamily: 'Acme')),
                                    TextSpan(
                                      text: _emoji(comments[index].madeIn),
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 30,
                                          fontFamily: 'Acme'),
                                    ),
                                    TextSpan(text: "\n"),
                                    TextSpan(
                                      text: "${comments[index].comment}",
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 20,
                                          fontFamily: 'Acme'),
                                    )
                                  ]),
                                )
                              ],
                            ),
                          )),
                    )
                  ],
                ),
              );
      },
    );
  }

  _drawerHandler() {
    return Container(
      height: 60,
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        onVerticalDragStart: (details) {
          controller.isCompleted ? controller.reverse() : controller.forward();
        },
        child: Container(
          alignment: Alignment.center,
          color: Colors.transparent,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 25),
            height: 3,
            width: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.black),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: animation.value,
      left: 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          color: Colors.grey[300],
        ),
        child: Column(children: <Widget>[
          _drawerHandler(),
          showStarsAndRating(Theme.of(context).primaryColor),
          Container(color: Colors.grey[300], height: 10),
          Container(
              color: Colors.grey[300],
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Text(
                "${country}'s average price for a $beerLabel is $beerPrice",
                textAlign: TextAlign.center,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 30,
                  fontFamily: 'Acme',
                  color: Colors.grey[800],
                ),
              )),
          Container(color: Colors.grey[300], height: 10),
          Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.center,
                      child: _createCommentsView()),
                  _makeCommentWidget
                ],
              ))
        ]),
      ),
    );
  }
}
