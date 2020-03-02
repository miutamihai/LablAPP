
import 'dart:io';

import 'package:compare_that_price/widgets/show_results.dart';
import 'package:flutter/material.dart';
import 'show_results.dart';

class ShowImage extends StatelessWidget {
  final String path;

  ShowImage(this.path);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(child: Image.file(File(path))),
      Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: "btn1",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.keyboard_return,
                  ),
                ),
                Text("Repeat")
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: "btn2",
                  onPressed: () async {
                    File image = File(path);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ShowResult(image: image)),
                    );
                  },
                  child: Icon(Icons.arrow_forward),
                ),
                Text("Submit")
              ],
            )
          ])
    ]);
  }
}