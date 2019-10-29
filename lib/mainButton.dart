import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String text;
  final Function selectHandler;

  MainButton(this.text, this.selectHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      child: RaisedButton(
          color: Colors.blue,
          textColor: Colors.white,
          child: Text(text),
          onPressed: () => selectHandler(text),
        ),
    );
  }
}