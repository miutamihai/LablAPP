import 'package:compare_that_price/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'smart_flare_animation.dart';
import 'package:flutter/painting.dart';



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
              FlareActor(
                "assets/animations/flow_bkg.flr",
                animation: "Flow",
                color: Colors.grey,
              ),
              Stack(
                children: <Widget>[
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
                                  passwordField(paddingTop: paddingTopPasswordField),
                                  Stack(
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
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SmartFlareAnimation('navigate'),
                  ),
                ],
              )
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

  Widget emailField({double paddingTop}) {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop == null ? 30 : paddingTop),
      child: Material(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0)),
        child: TextFormField(
          controller: emailController,
          onFieldSubmitted: (_) => submitData(),
          decoration: InputDecoration(
            hintText: "email@example.com",
            filled: true,
            fillColor: Colors.white,
            hintStyle: TextStyle(color: Colors.black87.withOpacity(0.5)),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding:
            EdgeInsets.only(top: 16, bottom: 16, left: 10),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          cursorColor: Colors.amberAccent,
        ),
      ),
    );
  }

  Widget passwordField({double paddingTop}) {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop == null ? 30 : paddingTop),
      child: Material(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0)),
        child: TextFormField(
          controller: passwordController,
          onFieldSubmitted: (_) => submitData(),
          decoration: InputDecoration(
            hintText: "password",
            filled: true,
            fillColor: Colors.white,
            hintStyle: TextStyle(color: Colors.black87.withOpacity(0.5)),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding:
            EdgeInsets.only(top: 16.0, bottom: 16, left: 10,),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          obscureText: true,
          cursorColor: Colors.amberAccent,
        ),
      ),
    );
  }

  Widget submitButton(context) {
    return Expanded(
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.only(bottom: 30),
              width: MediaQuery.of(context).size.width / 4,
              height: 75,
              child: RaisedButton(
                elevation: 0,
                highlightElevation: 10,
                color: Colors.amberAccent[400],
                highlightColor: Colors.amberAccent[400],
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {},
              ),
            ),
          )
      ),
    );
  }
  Widget registerButton(context) {
    return Expanded(
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.only(bottom: 30),
              width: MediaQuery.of(context).size.width / 4,
              height: 75,
              child: RaisedButton(
                elevation: 0,
                highlightElevation: 10,
                color: Colors.amberAccent[400],
                highlightColor: Colors.amberAccent[400],
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
                child: Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  submitData();
                },
              ),
            ),
          )
      ),
    );
  }

}
