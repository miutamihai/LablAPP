import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  final Function logIn;

  CreateAccount(this.logIn);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmationController = TextEditingController();

  void submitData() {
    final enteredEmail = emailController.text;
    final enteredPassword = passwordController.text;
    final confirmedPassword = confirmationController.text;

    if (enteredEmail.isEmpty || enteredPassword.isEmpty || confirmedPassword.isEmpty) {
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
                decoration: InputDecoration(labelText: 'Password'),
                controller: passwordController,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
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
    );
  }
}