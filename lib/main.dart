import 'package:flutter/material.dart';

import './widgets/log_in.dart';
import './widgets/create_account.dart';
import './widgets/gallery.dart';
import './widgets/products_list.dart';
//import './widgets/imageInput.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compare that Price',
      theme: ThemeData(
        primarySwatch: Colors.brown,
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
  int _index = 0;
  bool _logInPage = true;

  void _setLogInOrCreatePage(bool isLogIn) {
    setState(() {
      this._logInPage = isLogIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compare that Price'),
      ),
      body: _index < 2
          ? _index == 0 ? Gallery() : ProductsList()
          : _logInPage ? LogIn(_setLogInOrCreatePage) : CreateAccount(_setLogInOrCreatePage),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).accentColor,
        onTap: (int index) {
          setState(() {
            this._index = index;
            this._logInPage = true; // set logIn button to login page
          });
        },
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.photo_library),
            title: new Text('Gallery'),
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
