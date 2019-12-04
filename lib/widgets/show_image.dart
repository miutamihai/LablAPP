import 'dart:io';

import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget{
  
  final String path;

  ShowImage(this.path);

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[
        Container(
          child: Image.file(File(path))
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child:
          Column(
            children: <Widget>[
              FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child:Icon(Icons.keyboard_return,),          
              ),
              Text("Repeat")
            ],
          )
        ),
        Align(
          alignment: Alignment.bottomRight,
          child:
          Column(
            children: <Widget>[
              FloatingActionButton(
              onPressed: () {
                //Navigator.pop(context);
              },
              child:Icon(Icons.arrow_forward),          
              ),
              Text("Submit")
            ],
          )
        )
      ],
    );
  }
  
}