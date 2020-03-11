import 'package:flutter/material.dart';

class MakeCommentWidget extends StatefulWidget {
  @override
  _MakeCommentWidgetState createState() => _MakeCommentWidgetState();
}

class _MakeCommentWidgetState extends State<MakeCommentWidget> {
  final _commentKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();

  @override
  void initState() {
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
                    print('send tapped');
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
