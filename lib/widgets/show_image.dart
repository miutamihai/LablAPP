import 'dart:io';

import 'package:compare_that_price/widgets/show_results.dart';
import 'package:compare_that_price/widgets/show_result_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ShowImage extends StatelessWidget{
  
  final String path;

  ShowImage(this.path);


  Future<String> sendImage(File image) async {
    var uri = Uri.parse('https://lablapi.appspot.com/');
    Map<String, String> headers = { 'content-type': 'multipart/form-data' };
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(headers);
    var imageToBeSent = http.MultipartFile('file', image.openRead(), await image.length(),
        filename: 'sent-file.png');
    request.fields.addEntries([MapEntry('password', 'L@blAPI1268.!'),
      MapEntry('country', 'Ireland'),
    ]);
    request.files.add(imageToBeSent);
    var response = await request.send();
    String requestedData;
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      requestedData = value;
    });
    return requestedData;
  }



  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[
        Container(
          child: 
               Image.file(File(path))
        ),
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
                File image = File(path);
                String response = await sendImage(image);
                Navigator.push(context, 
                //MaterialPageRoute(builder: (context) => ShowResult( finalResponse: response)),
                  MaterialPageRoute(builder: (context) => ShowResultAlert(result: response,))
                );
              },
              child:Icon(Icons.arrow_forward),          
              ),
              Text("Submit")
              ],
            )
          ]
        ) 
      ]
    );
  }

}