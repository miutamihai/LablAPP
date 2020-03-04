import 'dart:io';

import 'package:flutter/material.dart';
import 'show_image_animation.dart';

class ShowImage extends StatelessWidget {
  final String path;

  ShowImage(this.path);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(child: Image.file(File(path))),
      Align(
        alignment: Alignment.bottomCenter,
        child: AcceptOrRepeat(
          image: File(path),
        ),
      )
    ]);
  }
}
