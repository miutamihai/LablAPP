import 'package:compare_that_price/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'smart_flare_animation.dart';
import 'package:flutter/painting.dart';
import 'login_form_fields.dart';


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
    return Scaffold(
      backgroundColor: Colors.white70,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double paddingTopEmailField = 10;
          double paddingTopPasswordField = 10;

          if (constraints.constrainHeight() <= 300) {
            paddingTopEmailField = 5;
            paddingTopPasswordField = 15;
          }

          return Stack(
            children: <Widget>[
              Container(
                child: FlareActor(
                  "assets/animations/flow_bkg.flr",
                  animation: "Flow",
                  color: Colors.grey,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.only(left: 25, right: 25, top: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.center,
                        child: FlareActor(
                          'assets/animations/BeerFromTheClouds.flr',
                          animation: 'Hover',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: loginText(),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Form(
                          child: Column(
                            //mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              emailField(paddingTop: paddingTopEmailField),
                              passwordField(
                                  paddingTop: paddingTopPasswordField),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  submitButton(context),
                                  registerButton(context),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SmartFlareAnimation('navigate'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget loginText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text("Welcome,",
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                )),
          ),
        ),
        Text(
          "Sign in to continue",
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

}
