import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:labl_app/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:labl_app/navigation/custom_app_router.dart';
import 'log_in.dart';

class AccountDetails extends StatefulWidget {
  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> with SingleTickerProviderStateMixin,
    AutomaticKeepAliveClientMixin<AccountDetails> {
  AnimationController _controller;
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<String> availableCurrencies = ['Euros', 'Dollars'];
  String _selectedCurrency = 'Dollars';
  String _userName = '';
  int _numberOfScans = 0;
  var _firestoreService;
  DocumentReference _document;
  String profileImage = 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.iconfinder.com%2Ficons%2F3273769%2Fempty_image_picture_placeholder_icon&psig=AOvVaw2uSARERdJv82tA4y2fZjjp&ust=1583538146682000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCMifqbnBhOgCFQAAAAAdAAAAABAD';
  ScrollController _mainController = ScrollController(
    initialScrollOffset: 100,
    keepScrollOffset: true
  );
  bool _isEditing = false;
  @override
  bool get wantKeepAlive => true;

  Future<void> loadImageFromStorage(String name) async {
    String link = "user_profile_pictures/$name.jpg";
    await FirebaseStorage.instance.ref().child(link).getDownloadURL().then((value){
      setState(() {
        print('got image');
        profileImage = value.toString();
      });
    });
  }


  Future<void> getUserName() async {
    await _auth.currentUser().then((value){
      _document = _firestoreService.Users.document(value.email);
      print(value.email);
      _document.get().then((value) {
        setState(() {
         _userName = value['Name'];
         _selectedCurrency = value['Preffered currency'];
         _numberOfScans = value['Number of scans'];
         loadImageFromStorage(_userName);
        });
      });
    });
  }

  @override
  void didChangeDependencies(){
    setState(() {
      _firestoreService= Provider.of<FireStoreService>(context);
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    getUserName();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _prefferedCurrency(){
    return Column(
      children: <Widget>[
        Text(
          'Preffered currency:',
          style: TextStyle(
              color: Colors.grey[800],
              fontSize: 18
          ),
        ),
        DropdownButton(
          iconSize: 60,
          hint: Text(
              _selectedCurrency),
          value: _selectedCurrency,
          onChanged: (newValue) {
            setState(() {
              _selectedCurrency = newValue.toString();
            });
          },
          items: _isEditing ? availableCurrencies.map((location) {
            return DropdownMenuItem(
              child: new Text(
                location,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 18
                ),
              ),
              value: location,
            );
          }).toList() : null,
        )
      ],
    );
  }

  Widget _welcomeText(){
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            'Hi, ${_userName}',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey[800],
                fontSize: 30
            ),
          ),
          Text(
            'Here are your account details',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey[800],
                fontSize: 18
            ),
          ),
        ],
      )
    );
  }

  Widget _profileAvatar(){
    return Align(
      alignment: Alignment.center,
      child: CircleAvatar(
        radius: 80,
        backgroundImage: NetworkImage(profileImage),
        backgroundColor: Colors.white70,
        child: Opacity(
          opacity: (_isEditing ? 1.0 : 0.0),
          child: Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.add_photo_alternate,
                  color: Colors.amber,
                  size: 40,
                ),
              )
          ),
        )
      ),
    );
  }

  Widget _numberOfScansWidget(){
    if(_isEditing)
      return SizedBox(
        height: 0,
      );
    else
      return Text(
        'Number of scans: ${_numberOfScans}',
        style: TextStyle(
            color: Colors.grey[800],
            fontSize: 18
        ),
      );
  }

  Future goToLoginPage() async{
    Navigator.of(this.context).push(
        new AppPageRoute(shouldGoToTheRight: true, builder: (BuildContext context){
          return LogIn(_auth);
        })
    );
  }

  Widget _editButton() {
    return GestureDetector(
      onTap: (){
        setState(() {
          _isEditing = true;
        });
      },
      child: Container(
        width: MediaQuery.of(this.context).size.width / 4,
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
          _isEditing ? 'Save changes' : 'Edit',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _logOutButton() {
    return GestureDetector(
      onTap: () async {
        await _auth.signOut();
        goToLoginPage();
      },
      child: Container(
        width: MediaQuery.of(this.context).size.width / 3,
        height: 60,
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
          'Log Out',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _mainController,
        child: Container(
          color: Colors.white70,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.865,
                child: FlareActor(
                  "assets/animations/flow_bkg.flr",
                  animation: "Flow",
                  color: Colors.grey,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    _profileAvatar(),
                    _welcomeText(),
                    SizedBox(
                      height: 20,
                    ),
                    _prefferedCurrency(),
                    _numberOfScansWidget(),
                    _editButton(),
                    SizedBox(
                      height: 80,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: _logOutButton(),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
