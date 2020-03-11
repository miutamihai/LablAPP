import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flare_flutter/flare_actor.dart';
import 'package:labl_app/navigation/custom_app_router.dart';
import 'package:labl_app/navigation/base_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'log_in.dart';

class SignUpPage extends StatefulWidget {
  final FirebaseAuth authInstance;
  SignUpPage({Key key, this.authInstance}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState(this.authInstance);
}

class _SignUpPageState extends State<SignUpPage> {
  File _image;
  List<String> availableCurrencies = ['Euros', 'Dollars'];
  String _selectedCurrency = 'Dollars';
  FirebaseAuth authInstance;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _username;
  String _password;
  bool hasUploadedProfilePicture = false;
  bool hasSelectedPrefferedCurrency = false;
  FirebaseStorage _storage = FirebaseStorage.instance;
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  ScrollController _arrowsController = ScrollController();
  ScrollController _mainScrollController = ScrollController(
    initialScrollOffset: 10,
    keepScrollOffset: true
  );

  _SignUpPageState(_authInstance) {
    this.authInstance = _authInstance;
  }

  @override
  void initState(){
    super.initState();
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future<void> uploadPic(String username) async {
    //Create a reference to the location you want to upload to in firebase
    _storage.ref().child("user_profile_pictures/").child('${username}.jpg')
        .putData(_image.readAsBytesSync(), StorageMetadata(
      contentType: 'image/jpeg'
    ));
    hasUploadedProfilePicture = true;
  }

  Future goToCameraPage() async{
    await new Future.delayed(const Duration(milliseconds: 100));
    Navigator.of(this.context).push(
        new AppPageRoute(shouldGoToTheRight: true ,builder: (BuildContext context){
          return BaseWidget(2);
        }));
  }

  Future goToLoginPage() async{
    Navigator.of(this.context).push(
      new AppPageRoute(shouldGoToTheRight: true, builder: (BuildContext context){
        return LogIn(authInstance);
      })
    );
  }
  TextEditingController getController(String fieldName){
    switch(fieldName){
      case 'Display name':
        return _nameController;
      case 'Email':
        return _emailController;
      case 'Password':
        return _passwordController;
    }
  }

  FocusNode selectFocus(String fieldName){
    switch(fieldName){
      case 'Display name':
        return _nameFocus;
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
              if(title == 'Display name')
                FocusScope.of(context).requestFocus(_emailFocus);
              else if(title == 'Email')
                FocusScope.of(context).requestFocus(_passwordFocus);
              else
                FocusScope.of(context).unfocus();
            },
          )
        ],
      ),
    );
  }
  
  Future<void> updateUserCollection(String email, String username) async{
    print('adding user to collection');
    await Firestore.instance.document("Users/" + email).setData({
      "Name": username,
      "Preffered currency": _selectedCurrency,
      "Has profile picture": hasUploadedProfilePicture
    }).then((value){
      print('user added to collection');
    });
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap: () async{
        if (_formKey.currentState.validate()) {
          _email = _emailController.text;
          _username = _nameController.text;
          _password = _passwordController.text;
          uploadPic(_username);
          try{
            await authInstance.createUserWithEmailAndPassword(email: _email,
                password: _password);
            print('document instantiated');
            updateUserCollection(_email, _username);
          }
          catch(signUpError) {
            print('catch called');
            if (signUpError is PlatformException) {
              if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
                print('email already used');
              }
            }
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
          'Register Now',
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
        child: DraggableScrollbar.arrows(
          backgroundColor: Colors.grey[800],
          controller: _arrowsController,
          alwaysVisibleScrollThumb: true,
          child: ListView(
            controller: _arrowsController,
            children: <Widget>[
              _entryField("Display name", false),
              _entryField('Email', false),
              _entryField('Password', true),
              DropdownButton(
                hint: Text(
                    'Please choose a preffered currency'),
                value: _selectedCurrency,
                onChanged: (newValue) {
                  setState(() {
                    _selectedCurrency = newValue.toString();
                  });
                },
                items: availableCurrencies.map((location) {
                  return DropdownMenuItem(
                    child: new Text(location),
                    value: location,
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: getImage,
                    tooltip: 'Pick profile picture',
                    child: Icon(Icons.add_a_photo),
                  ),
                  Text('Pick a fitting profile picture'),
                  Icon((_image == null ? Icons.check_box_outline_blank : Icons.check_box)),
                ],
              ),
              Container(
                height: 10,
                color: Colors.white70,
              )
            ],
          ),
        )
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
            'Tell us some things about you',
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
          controller: _mainScrollController,
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
                            'Already registered?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 18
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              goToLoginPage();
                            },
                            child: Text(
                              'Log in!',
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
          ),
        ));
  }
}
