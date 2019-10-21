import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  void logButtonPress(String label) {
    print('Button: "' + label + '" was pressed!');
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
        body: Center (
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                child: Text(buttonsText[0]),
                onPressed: () => logButtonPress(buttonsText[0]),
              ),
              RaisedButton(
                child: Text(buttonsText[1]),
                onPressed: () => logButtonPress(buttonsText[1]),
              ),
              RaisedButton(
                child: Text(buttonsText[2]),
                onPressed: () => logButtonPress(buttonsText[2]),
              ),
              // for (var i = 0; i < buttonsText.length; i++) {
              //   RaisedButton(
              //   child: Text(buttonsText[i]),
              //   onPressed: () => logButtonPress(buttonsText[i]),
              // ),
              // }
            ],
          ),
        ),
      ),
    );
  }
}
