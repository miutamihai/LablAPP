import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ShowResult extends StatefulWidget {

  final Response finalResponse;

  ShowResult({@required this.finalResponse});

  @override
  _ShowResultState createState() => _ShowResultState();
}

class _ShowResultState extends State<ShowResult> {

  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.finalResponse.data),
    );
  }
}