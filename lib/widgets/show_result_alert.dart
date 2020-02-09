
import 'package:flutter/material.dart';

class ShowResultAlert extends StatefulWidget {
  final String result;

  ShowResultAlert({@required this.result});

  @override
  _ShowResultAlertState createState() => _ShowResultAlertState();
}

class _ShowResultAlertState extends State<ShowResultAlert> {
  @override
  Widget build(BuildContext context){
    return AlertDialog(
      title: new Text('Result'),
      content: new Text(widget.result),
    );
  }
}