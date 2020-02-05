import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  final Function logIn;

  LogIn(this.logIn);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void submitData() {
    final enteredEmail = emailController.text;
    final enteredPassword = passwordController.text;

    if (enteredEmail.isEmpty || enteredPassword.isEmpty) {
      return;
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
    );
  }
}
