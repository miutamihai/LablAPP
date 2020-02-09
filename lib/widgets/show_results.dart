import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ShowResult extends StatefulWidget {

  final String finalResponse;

  ShowResult({@required this.finalResponse});

  @override
  _ShowResultState createState() => _ShowResultState();
}

class _ShowResultState extends State<ShowResult> {
  @override
  Widget build(BuildContext context) {
    print(widget.finalResponse);
    return Container(
      child: Text(widget.finalResponse),
    );
  }
}