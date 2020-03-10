import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/painting.dart';
import 'login_form_fields.dart';


class LogIn extends StatefulWidget {
  static const String id = 'account';
  final String uniqueID;
  LogIn(this.uniqueID);
  @override
  _LogInState createState() => _LogInState(this.uniqueID);
}

class _LogInState extends State<LogIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String uniqueID;

  _LogInState(String _uniqueID){
    this.uniqueID = _uniqueID;
  }

  void submitData() async {
    final enteredEmail = emailController.text;
    final enteredPassword = passwordController.text;

    if (enteredEmail.isEmpty || enteredPassword.isEmpty) {
      return;
    }

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: FlareActor(
              "assets/animations/flow_bkg.flr",
              animation: "Flow",
              color: Colors.grey,
            ),
          ),
          Positioned(
            top: 20,
            child: Align(
              alignment: Alignment.center,
              child: FlareActor(
                'assets/animations/BeerFromTheClouds.flr',
                animation: 'Hover',
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(left: 25, right: 25, top: 100),
            child: ListView(
              children: <Widget>[
                Container(
                  child: loginText(),
                ),
                Container(
                  child: Form(
                    child: Column(
                      //mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        usernameField(paddingTop: 10),
                        passwordField(
                            paddingTop: 10),
                        Align(
                          alignment: Alignment.center,
                          child: submitButton(context),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }

  Widget loginText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Align(
          alignment: Alignment.bottomLeft,
          child: Text("Welcome,",
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
              )),
        ),
        Text(
          "Tell us some things about you",
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

}
