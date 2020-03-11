import 'show_main_info.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'loading_screen.dart';
import 'package:labl_app/navigation/custom_app_router.dart';
import 'package:labl_app/navigation/base_widget.dart';
import 'package:geolocator/geolocator.dart';

// ignore: must_be_immutable
class ShowResult extends StatefulWidget {
  final image;

  const ShowResult({Key key, this.image}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShowResultState(image);

}

class _ShowResultState extends State<ShowResult>{
  var image;
  String country = 'Germany';

  _ShowResultState(_image){
    this.image = _image;
  }

  Future<void> getLocation() async{
    print(GeolocationPermission.location.value);
    await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((position) async {
      print(position.toString());
      await Geolocator().placemarkFromPosition(position).then((placemark){
        setState(() {
          country = placemark[0].country;
        });
      });
    });
  }

  Future<String> sendImage(File image) async {
    var uri = Uri.parse('https://lablapi.appspot.com/');
    Map<String, String> headers = {'content-type': 'multipart/form-data'};
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(headers);
    var imageToBeSent = http.MultipartFile(
        'file', image.openRead(), await image.length(),
        filename: 'sent-file.png');
    request.fields.addEntries([
      MapEntry('password', 'L@blAPI1268.!'),
      MapEntry('country', country),
    ]);
    request.files.add(imageToBeSent);
    var response = await request.send();
    var finalResult = await response.stream.bytesToString();
    return finalResult;
  }

  @override
  void initState(){
    getLocation();
    super.initState();
  }

  Widget showImage(MediaQueryData mediaQueryData) {
    return Container(
        color: Colors.white,
        height: mediaQueryData.size.height,
        width: mediaQueryData.size.width,
        child: //Image.asset(image),
        FittedBox(
          fit: BoxFit.fitHeight,
          child: Image.file(image),
        ) // test purposes
    );
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: sendImage(image),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loader();
        } else
          return  Stack(children: <Widget>[
            showImage(MediaQuery.of(context)),
            ShowMainInfo(snapshot.data, country),
            Positioned(
              top: 40,
              left: 40,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(new AppPageRoute(
                      shouldGoToTheRight: false,
                      builder: (BuildContext context) =>
                      new BaseWidget(2)));
                },
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.amberAccent,
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white70,
                    size: 50,
                  ),
                ),
              ),
            )
          ],
          );
      },
    );
  }
}
