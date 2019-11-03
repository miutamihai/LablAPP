import 'package:flutter/material.dart';

import './widgets/takePicture.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compare that Price',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.amber,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compare that Price'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('camera'),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     IconButton(
          //       icon: Icon(Icons.photo_library),
          //       onPressed: () {},
          //     ),
          //     IconButton(
          //       icon: Icon(Icons.camera),
          //       onPressed: () {},
          //     ),
          //     FlatButton(
          //       child: Text('Log In'),
          //       onPressed: () {},
          //     ),
          //   ],
          // ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).accentColor,
        currentIndex: 1,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.photo_library),
            title: new Text('Gallery'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.camera),
            title: new Text('Take a Picture'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Log In'),
          ),
        ],
      ),
    );
  }
}
