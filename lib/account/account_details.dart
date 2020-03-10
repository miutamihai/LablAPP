import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:labl_app/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class AccountDetails extends StatefulWidget {
  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String _userName = '';
  var _firestoreService;
  DocumentReference _document;

  Future<void> getUserName() async {
    await _auth.currentUser().then((value){
      _document = _firestoreService.Users.document(value.email);
      print(value.email);
      _document.get().then((value) {
        setState(() {
         _userName = value['Name'];
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: Text(
          'Hello, ${_userName}'
        ),
      ),
    );
  }
}
