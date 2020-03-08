import 'show_main_info.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'loading_screen.dart';

class ShowResult extends StatelessWidget {
  final image;

  Future<String> sendImage(File image) async {
    var uri = Uri.parse('https://lablapi.appspot.com/');
    Map<String, String> headers = {'content-type': 'multipart/form-data'};
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(headers);
    var imageToBeSent = http.MultipartFile(
        'file', image.openRead(), await image.length(),
        filename: 'sent-file.png');
    request.fields.addEntries([
      MapEntry('password', 'L@blAPI1268.!'),
      MapEntry('country', 'Ireland'),
    ]);
    request.files.add(imageToBeSent);
    var response = await request.send();
    var finalResult = await response.stream.bytesToString();
    return finalResult;
  }

  ShowResult({@required this.image});

  Widget showImage(MediaQueryData mediaQueryData) {
    return Container(
        color: Colors.white,
        height: mediaQueryData.size.height,
        width: mediaQueryData.size.width,
        child: //Image.asset(image),
            FittedBox(
          fit: BoxFit.fitHeight,
          child: Image.file(image),
        ) // test purposes
        );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: sendImage(image),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Loader();
            }
            else
              return SafeArea(
                child: Stack(children: <Widget>[
                  showImage(MediaQuery.of(context)),
                  ShowMainInfo(snapshot.data),
                ]),
              );
        },
    );


  }
}

