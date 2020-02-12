import 'package:compare_that_price/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import './show_user.dart';

class LogIn extends StatefulWidget {
  static const String id = 'log_in';
  final Function logIn;

  LogIn(this.logIn);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  void submitData() async {
    final enteredEmail = emailController.text;
    final enteredPassword = passwordController.text;

    if (enteredEmail.isEmpty || enteredPassword.isEmpty) {
      return;
    }

    setState(() {
      showSpinner = true;
    });
    try {
      final newUser = await _auth.signInWithEmailAndPassword(
          email: enteredEmail, password: enteredPassword);
      if (newUser != null) {
        Navigator.pushNamed(context, MyHomePage.id);
      }
      setState(() {
        showSpinner = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Card(
        elevation: 5,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Email'),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    onSubmitted: (_) => submitData(),
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                    controller: passwordController,
                    onSubmitted: (_) => submitData(),
                  ),
                  RaisedButton(
                    child: Text('Log in'),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: submitData,
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text('Not yet registered?'),
                        RaisedButton(
                          child: Text('Create an account'),
                          textColor: Theme.of(context).primaryColor,
                          onPressed: () =>
                              widget.logIn(false), // go to createAccount page
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
