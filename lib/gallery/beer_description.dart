import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BeerDescription extends StatefulWidget {
  final DocumentReference document;

  const BeerDescription(this.document);
  @override
  _BeerDescriptionState createState() => _BeerDescriptionState(document);
}

class _BeerDescriptionState extends State<BeerDescription>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  DocumentReference document;
  String description = '';

  _BeerDescriptionState(DocumentReference document) {
    this.document = document;
  }

  Future<void> getBeerDescription() async {
    await document.get().then((value) {
      setState(() {
        print('got beer description');
        description = value['Description'].toString();
      });
    });
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    getBeerDescription();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
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
      child: Container(
          constraints: new BoxConstraints.expand(),
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(3),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Acme'),
              ),
            )
          )),
    );
  }
}
