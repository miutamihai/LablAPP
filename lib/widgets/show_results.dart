import 'package:flutter/material.dart';

class ShowResult extends StatefulWidget {
  static const String id = 'show_result';
  final String finalResponse;

  ShowResult({@required this.finalResponse});

  @override
  _ShowResultState createState() => _ShowResultState();
}

class _ShowResultState extends State<ShowResult> {
  @override
  Widget build(BuildContext context) {
    if(widget.finalResponse == null){
      print("ERROR NULL STRING");
      return Container();
    }
    else{
      return Container(
      child: Text(widget.finalResponse),
    );
    }
    
  }
}