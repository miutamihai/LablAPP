import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

Widget emailField({double paddingTop}) {
  return Padding(
    padding: EdgeInsets.only(top: paddingTop == null ? 30 : paddingTop),
    child: Material(
      elevation: 0,
      shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
      child: TextFormField(
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
  return Align(
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
  );
}
Widget registerButton(context) {
  return Align(
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
            onPressed: () {},
          ),
        ),
      )
  );
}
