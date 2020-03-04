import 'package:compare_that_price/widgets/camera_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './widgets/welcome_splash_screen.dart';
//import './widgets/gallery.dart';
//import './widgets/imageInput.dart';
import './widgets/show_user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LABL',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Acme',
        primarySwatch: Colors.green,
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
      body:
          Stack(children: <Widget>[
            //WelcomeSplashScreen()
            CameraPage()
          ],
          )
    );
  }
}
