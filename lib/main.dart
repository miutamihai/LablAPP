import 'package:flutter/material.dart';

import './mainButton.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _buttonsText = [
    'Take a Picture',
    'Log In',
    'Sign Up',
  ];
  int _selectedButtonIndex;
  
  void _buttonPressed(int index, List<String> buttons) {
    setState(() {
     _selectedButtonIndex = index;
    });
    print('Button: "' + buttons[index] + '" was pressed!');
  }

  @override
  Widget build(BuildContext context) {
    

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Compare that price.\nWelcome!'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MainButton(0, _buttonsText, _buttonPressed),
              MainButton(1, _buttonsText, _buttonPressed),
              MainButton(2, _buttonsText, _buttonPressed),
            ],
          ),
        ),
      ),
    );
  }
}
