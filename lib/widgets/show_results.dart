import 'package:compare_that_price/widgets/show_main_info.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:path/path.dart';

class ShowResult extends StatelessWidget {
  final finalResponse;
  final image;

  ShowResult({@required this.finalResponse, @required this.image});

  Widget showImage(MediaQueryData mediaQueryData) {
    return Container(
        color: Colors.white,
        height: mediaQueryData.size.height,
        width: mediaQueryData.size.width,
        child: //Image.asset(image),
            FittedBox(
          fit: BoxFit.fitHeight,
          child: Image.file(image),
                //image //TODO: This should be the final implementation
        ) // test purposes
        );
  }

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Stack(children: <Widget>[
        showImage(MediaQuery.of(context)),
        ShowMainInfo(finalResponse),
      ]),
    );
  }
}

