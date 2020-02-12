import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './widgets/log_in.dart';
import './widgets/create_account.dart';
//import './widgets/gallery.dart';
import './widgets/camera_page.dart';
import './widgets/products_list.dart';
//import './widgets/imageInput.dart';
import './widgets/show_user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LABL',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        accentColor: Colors.amber,
      ),
      //home: MyHomePage(),
      initialRoute: MyHomePage.id,
      routes: {
        MyHomePage.id: (context) => MyHomePage(),
        ShowUser.id: (context) => ShowUser(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const String id = 'my_home_page';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedUser;
  int _index = 1;
  bool _logInPage = true;
  bool _logOut = false;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void _setLogInOrCreatePage(bool isLogIn) {
    setState(() {
      getCurrentUser();
      this._logInPage = isLogIn;
    });
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        _logOut = true;
        loggedUser = user;
        print(loggedUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LABL'),
      ),
      body: _index < 2
          //? _index == 0 ? ProductsList() : Text('Camera placeholder')
          ? _index == 0 ? ProductsList() : CameraPage()
          : _logInPage ? LogIn(_setLogInOrCreatePage) : CreateAccount(_setLogInOrCreatePage),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).accentColor,
        onTap: (int index) {
          setState(() {
            if (_logOut && index==2) {
              _auth.signOut();
              this._logOut = false;
            }
            else {
              this._index = index;
              this._logInPage = true; // set logIn button to login page
            }
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
            title: _logOut ? Text('Log Out') : Text('Log In'),
          ),
        ],
      ),
    );
  }
}
