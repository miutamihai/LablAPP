import 'package:flutter/material.dart';

import './mainButton.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  void logButtonPress(String label) {
    print('Button: $label was pressed!');
  }

  @override
  Widget build(BuildContext context) {
    var buttonsText = [
      'Take a Picture',
      'Log In',
      'Sign Up',
    ];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Compare that price.\nWelcome!'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MainButton(buttonsText[0], logButtonPress),
              MainButton(buttonsText[1], logButtonPress),
              MainButton(buttonsText[2], logButtonPress),
            ],
          ),
        ),
      ),
    );
  }
}
