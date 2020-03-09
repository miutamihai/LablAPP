import 'package:flutter/material.dart';
import 'package:labl_app/services/firestore_service.dart';
import 'package:labl_app/welcome_screen/welcome_screen.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MultiProvider(
      providers: [
        Provider<FireStoreService>(
          create: (_) => FireStoreService(),
        ),
      ],
      child: MaterialApp(
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
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const String id = 'my_home_page';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        WelcomeScreen()
      ],
    ));
  }
}
