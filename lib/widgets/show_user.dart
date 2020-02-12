import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ShowUser extends StatefulWidget {
  static const String id = 'show_user';

  @override
  _ShowUserState createState() => _ShowUserState();
}

class _ShowUserState extends State<ShowUser> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedUser = user;
        print(loggedUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: FloatingActionButton(
      onPressed: () {
        _auth.signOut();
        Navigator.pop(context);
      },
    ));
  }
}
