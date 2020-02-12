import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:compare_that_price/widgets/show_results.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ShowImage extends StatelessWidget {
  static const String id = 'show_image';
  final String path;

  ShowImage(this.path);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(child: Image.file(File(path))),
      Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
              heroTag: "btn1",
              onPressed: () {
                Navigator.pop(context);
              },
              child:Icon(Icons.keyboard_return,),          
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
                String response= await sendImage();
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => ShowResult( finalResponse: response, /* finalResponse: response */)),
                );
              },
              child:Icon(Icons.arrow_forward),          
              ),
              Text("Submit")
              ],
            )
          ])
    ]);
  }

  Future<String> sendImage() async {
    
    File image = File(path);

    var uri = Uri.parse('https://lablapi.appspot.com');

    Map<String, String> headers = { "content-type": "multipart/form-data" };

    var request = new http.MultipartRequest("POST", uri);
    request.headers.addAll(headers);
    List<int> imageBytes = await image.readAsBytes();
    print("Bytes:");
    print(imageBytes.length);
    print(imageBytes.toString());
    request.fields.addEntries([new MapEntry('password', 'L@blAPI1268.!'),
      new MapEntry('country', 'Ireland'),
      //new MapEntry('image', imageBytes.toString()),
    ]);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      return value;
    });
    
  }
}
