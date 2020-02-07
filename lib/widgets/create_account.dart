import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  void submitData() async {
    final _enteredEmail = emailController.text;
    final _enteredPassword = passwordController.text;
    final _confirmedPassword = confirmationController.text;

    if (_enteredEmail.isEmpty ||
        _enteredPassword.isEmpty ||
        _confirmedPassword.isEmpty) {
      return;
    }

    if (_enteredPassword != _confirmedPassword) {
      return;
    }

    print(_enteredEmail);
    print(_enteredPassword);
    print(_confirmedPassword);

    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: _enteredEmail, password: _enteredPassword);
      if (newUser != null) {
        Navigator.pushNamed(context, ShowUser.id);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
                        onPressed: () => widget.logIn(true), // go to logIn page
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
