import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:labl_app/models/comment.dart';


class MakeCommentWidget extends StatefulWidget {
  final DocumentReference userData;
  final String countryCode;
  final DocumentReference document;
  final List<Comment> comments;

  const MakeCommentWidget(this.userData, this.countryCode, this.document, this.comments);
  @override
  _MakeCommentWidgetState createState() => _MakeCommentWidgetState(userData, countryCode, document, comments);
}

class _MakeCommentWidgetState extends State<MakeCommentWidget> {
  final _commentKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  DocumentReference userData;
  String username;
  String countryCode;
  DocumentReference document;
  List<dynamic> comments;

  _MakeCommentWidgetState(DocumentReference _userData, String _countryCode,
      DocumentReference _document,List<Comment> _comments){
    this.userData = _userData;
    this.countryCode = _countryCode;
    this.document = _document;
    this.comments = List<dynamic>();
    _comments.forEach((comment) {
      this.comments.add({
        "Comment": comment.comment,
        "Made by": comment.username,
        "Made in": comment.madeIn
      });
    });
  }

  Future<void> getUsername(){
    userData.get().then((user){
      setState(() {
        username = user['Name'];
      });
    });
  }

  @override
  void initState() {
    getUsername();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 250,
      left: 20,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.amber[300],
            shape: BoxShape.rectangle,
            borderRadius: new BorderRadius.circular(40),
            boxShadow: <BoxShadow>[
              new BoxShadow(color: Colors.black,
                  blurRadius: 10.0,
                  offset: new Offset(0.0, 10.0))
            ],
          ),
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          height: 60,
          child: Form(
            key: _commentKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: SizedBox(
                    width: 250,
                    child: TextFormField(
                      controller: _commentController,
                      textInputAction: TextInputAction.done,
                      validator: (value){
                        if(value.isEmpty){
                          return 'Share your thoughts with us';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    var _comment = {
                      "Comment": _commentController.text,
                      "Made by": username,
                      "Made in": countryCode
                    };
                    print('Comment is made by ${username}');
                    comments.add(_comment);
                    print(comments.length);
                    print(comments.first);
                    document.updateData({"Comments": comments});
                    print('send tapped');
                    setState(() {

                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.amber,
                    radius: 30,
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.send,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
