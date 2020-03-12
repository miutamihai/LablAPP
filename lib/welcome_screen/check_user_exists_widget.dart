import 'package:flutter/material.dart';
import 'package:labl_app/welcome_screen/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class CheckUserExists extends StatefulWidget {
  @override
  _CheckUserExistsState createState() => _CheckUserExistsState();
}

class _CheckUserExistsState extends State<CheckUserExists> {

  Future<bool> checkUserExists() async {
    bool _userExists = false;
    await _auth.currentUser().then((value){
      if(value != null)
        _userExists = true;
    });
    return _userExists;
  }

  Future<void> getPermissions() async {
    await PermissionHandler().requestPermissions([PermissionGroup.camera, PermissionGroup.location,
      PermissionGroup.photos, PermissionGroup.storage, PermissionGroup.microphone, PermissionGroup.locationAlways]);
  }

  @override
  void initState() {
    getPermissions();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkUserExists(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
        if(snapshot.hasData){
          return WelcomeScreen(userExists: snapshot.data, authInstance: _auth);
        }
        return Container(
        );
      },
    );
  }
}
