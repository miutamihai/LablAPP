import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ShowImageWidget extends StatefulWidget {
  final String image;
  final String label;

  const ShowImageWidget({Key key, this.image, this.label}) : super(key: key);
  @override
  _ShowImageWidgetState createState() => _ShowImageWidgetState(image, label);
}

class _ShowImageWidgetState extends State<ShowImageWidget> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  String image;
  String label;

  _ShowImageWidgetState(String image, String label){
    this.image = image;
    this.label = label;
  }

  Future<void> loadImageFromStorage() async {
    await FirebaseStorage.instance.ref().child(image).getDownloadURL().then((value){
      print('await done');
      setState(() {
        image = value.toString();
        print(image);
      });
    });
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    loadImageFromStorage();
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
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: //Image.asset(image),
        FittedBox(
          fit: BoxFit.fitHeight,
          child: Image.network(image),
        ) // test purposes
    );
  }
}
