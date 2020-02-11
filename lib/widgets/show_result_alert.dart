
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
    if (widget.result==""){
      return AlertDialog(
        title: Text('Error Fetching Data From API'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Back'))
        ],
      );
    }
    else{
    return AlertDialog(
      title: new Text('Result'),
      content: new Text(widget.result),
    );
    }
   
  }
}