import 'package:flutter/material.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // var _buttonsText = [
  //   'Take a Picture',
  //   'Log In',
  //   'Sign Up',
  // ];
  //int _selectedButtonIndex;

  // void _buttonPressed(int index, List<String> buttons) {
  //   setState(() {
  //    _selectedButtonIndex = index;
  //   });
  //   print('Button: "' + buttons[index] + '" was pressed!');
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compare that Price',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.amber,
      ),
      home: MyHomePage(),
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: Text('Compare that price.\nWelcome!'),
      //   ),
      //   body: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         MainButton(0, _buttonsText, _buttonPressed),
      //         MainButton(1, _buttonsText, _buttonPressed),
      //         MainButton(2, _buttonsText, _buttonPressed),
      //       ],
      //     ),
      //   ),
      // ),
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
          Text('placeholder'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.photo_library),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.camera),
                onPressed: () {},
              ),
              FlatButton(
                child: Text('Log In'),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
