import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:labl_app/navigation/custom_app_router.dart';
import 'package:labl_app/navigation/base_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'sign_up.dart';


class LogIn extends StatefulWidget {
  final FirebaseAuth authInstance;
  LogIn(this.authInstance);
  @override
  _LogInState createState() => _LogInState(this.authInstance);
}

class _LogInState extends State<LogIn> {
  FirebaseAuth authInstance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  _LogInState(_authInstance){
    this.authInstance = _authInstance;
  }

  @override
  void initState(){
    super.initState();
  }

  Future goToCameraPage() async{
    await new Future.delayed(const Duration(milliseconds: 100));
    Navigator.of(this.context).push(
        new AppPageRoute(shouldGoToTheRight: true ,builder: (BuildContext context){
          return BaseWidget(2);
        }));
  }

  Future goToSignUpPage() async{
    Navigator.of(this.context).push(
        new AppPageRoute(shouldGoToTheRight: false, builder: (BuildContext context){
          return SignUpPage(authInstance: authInstance,);
        })
    );
  }

  TextEditingController getController(String fieldName){
    switch(fieldName){
      case 'Email':
        return _emailController;
      case 'Password':
        return _passwordController;
    }
  }

  FocusNode selectFocus(String fieldName){
    switch(fieldName){
      case 'Email':
        return _emailFocus;
      case 'Password':
        return _passwordFocus;
    }
  }

  Widget _entryField(String title, bool isPassword) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey[800]),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: getController(title),
            focusNode: selectFocus(title),
            textInputAction: (isPassword ? TextInputAction.done : TextInputAction.next),
            obscureText: isPassword,
            validator: (value){
              if (value.isEmpty) {
                return 'Enter something to remember';
              }
              return null;
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
            onFieldSubmitted: (v){
              if(title == 'Email')
                FocusScope.of(context).requestFocus(_passwordFocus);
              else
                FocusScope.of(context).unfocus();
            },
          )
        ],
      ),
    );
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap: (){
        if (_formKey.currentState.validate()) {
          _email = _emailController.text;
          _password = _passwordController.text;
          try{
            authInstance.signInWithEmailAndPassword(email: _email, password: _password);
          }
          catch(signUpError) {
            print('catch called');
          }
          goToCameraPage();
        }
      },
      child: Container(
        width: MediaQuery.of(this.context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.amberAccent, Colors.amber])),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _inputFields() {
    return Container(
        height: 250,
        child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                _entryField('Email', false),
                _entryField('Password', true),
                Container(
                  height: 10,
                  color: Colors.white70,
                )
              ],
            ),
        )
    );
  }

  Widget _title(){
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            'Welcome to LABL!',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey[800],
                fontSize: 30
            ),
          ),
          Text(
            'Login to continue',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey[800],
                fontSize: 20
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white70,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.865,
                  child: Hero(
                    tag: 'background-hero',
                    child: FlareActor(
                      "assets/animations/flow_bkg.flr",
                      animation: "Flow",
                      color: Colors.grey,
                    ),
                  )
                ),
                Positioned(
                  top: 60,
                  left: 60,
                  height: 300,
                  width: 300,
                  child: Align(
                    alignment: Alignment.center,
                    child: Hero(
                      tag: 'phone-hero',
                      child: FlareActor(
                        'assets/animations/BeerFromTheClouds.flr',
                        animation: 'Hover',
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 400,
                      ),
                      _title(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Not registred yet?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 18
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              goToSignUpPage();
                            },
                            child: Text(
                              'Sign in!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18
                              ),
                            ),
                          )
                        ],
                      ),
                      _inputFields(),
                      SizedBox(
                        height: 20,
                      ),
                      _submitButton(),
                    ],
                  ),
                ),
              ],
            ),
          )
        ));
  }

}
