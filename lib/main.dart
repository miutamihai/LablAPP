import 'package:flutter/material.dart';

import './widgets/imageInput.dart';

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
  int index = 0;

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
          RaisedButton(color: Theme.of(context).primaryColor, onPressed: () {},)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).accentColor,
        onTap: (int index) {
          setState(() {
            this.index = index;
          });},
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.photo_library),
            title: new Text('Gallery'),
            //activeIcon: 
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.camera),
            title: new Text('Camera'),
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
