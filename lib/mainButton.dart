import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final int index;
  final List<String> buttonsText;
  final Function selectHandler;

  MainButton(this.index, this.buttonsText, this.selectHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      child: RaisedButton(
          color: Colors.blue,
          textColor: Colors.white,
          child: Text(buttonsText[index]),
          onPressed: () => selectHandler(index, buttonsText),
        ),
    );
  }
}