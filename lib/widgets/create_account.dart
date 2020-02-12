import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import './show_user.dart';

class CreateAccount extends StatefulWidget {
  static const String id = 'create_account';
  final Function logIn;

  CreateAccount(this.logIn);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmationController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  void submitData() async {
    final enteredEmail = emailController.text;
    final enteredPassword = passwordController.text;
    final confirmedPassword = confirmationController.text;

    if (enteredEmail.isEmpty ||
        enteredPassword.isEmpty ||
        confirmedPassword.isEmpty) {
      return;
    }

    if (enteredPassword != confirmedPassword) {
      return;
    }

    print(enteredEmail);
    print(enteredPassword);
    print(confirmedPassword);

    setState(() {
      showSpinner = true;
    });
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: enteredEmail, password: enteredPassword);
      if (newUser != null) {
        Navigator.pushNamed(context, ShowUser.id);
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
                    //textAlign: TextAlign.center,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                    controller: passwordController,
                    onSubmitted: (_) => submitData(),
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Confirm password'),
                    controller: confirmationController,
                    onSubmitted: (_) => submitData(),
                  ),
                  RaisedButton(
                    child: Text('Create an account'),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: submitData,
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text('Already have an account?'),
                        RaisedButton(
                          child: Text('Log in'),
                          textColor: Theme.of(context).primaryColor,
                          onPressed: () =>
                              widget.logIn(true), // go to logIn page
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
