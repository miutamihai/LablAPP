import 'dart:io';

import 'package:compare_that_price/widgets/show_results.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

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
                    Dio dio = new Dio();
                    Response response = new Response();
                    response = await dio.post(
                      "https://lablapi.appspot.com/",
                      data: postTest(),
                      onSendProgress: (int sent, int total) {
                        print("$sent $total");
                      },
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShowResult(
                                finalResponse: response,
                              )),
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

  Future<FormData> postTest() async {
    return FormData.fromMap({
      "country": "Ireland",
      "password": "L@blAPI1268.!",
      "file": await MultipartFile.fromFile(
          './assets/images/budweiser-can-440ml.jpg',
          filename: "sent.png")
    });
  }
}
