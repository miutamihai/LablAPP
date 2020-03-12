import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:labl_app/show_results/show_main_info.dart';
import 'package:labl_app/show_results/show_image_widget.dart';
import 'package:labl_app/show_results/loading_screen.dart';
import 'package:geolocator/geolocator.dart';

class BeerDescription extends StatefulWidget {
  final DocumentReference document;
  final String label;
  final String image;

  const BeerDescription(this.document, this.label, this.image);
  @override
  _BeerDescriptionState createState() => _BeerDescriptionState(document, label, image);
}

class _BeerDescriptionState extends State<BeerDescription>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  DocumentReference document;
  String description = '';
  String label = '';
  String result = '';
  String image;
  String country;

  _BeerDescriptionState(DocumentReference document, String label, image) {
    this.document = document;
    this.label = label;
    this.image = image;
  }

  Future<void> getLocation()async{
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

  Future<void> getBeerDescription() async {
    await document.get().then((value) {
      setState(() {
        print('got beer description');
        description = value['Description'].toString();
      });
    });
  }

  Future<String> showBeerRatings(String label) async {
    var uri = Uri.parse('https://lablapi.appspot.com/get_average_price');
    Map<String, String> headers = {'content-type': 'multipart/form-data'};
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(headers);
    request.fields.addEntries([
      MapEntry('label', label),
      MapEntry('country', country),
    ]);
    var response = await request.send();
    var finalResult = await response.stream.bytesToString();
    print(finalResult);
    result = finalResult;
    return result;
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    getBeerDescription();
    getLocation();
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
        height: 1000,
        margin: const EdgeInsets.all(5),
        decoration: new BoxDecoration(
          color: Colors.amber[50],
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(20.0),
          boxShadow: <BoxShadow>[
            new BoxShadow(
                color: Colors.black,
                blurRadius: 10.0,
                offset: new Offset(0.0, 10.0))
          ],
        ),
        child: SizedBox(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(3),
                          child: Text(
                            description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Acme'),
                          ),
                        )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            print(image);
                            return FutureBuilder<String>(
                              future: showBeerRatings(label),
                              builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                                if(snapshot.connectionState == ConnectionState.waiting){
                                  return Loader();
                                }
                                else
                                  return Scaffold(
                                    body: SingleChildScrollView(
                                      child: Stack(children: <Widget>[
                                        ShowImageWidget(label: label, image: image),
                                        ShowMainInfo(snapshot.data, country),
                                      ]
                                      ),
                                    )
                                  );
                              },

                            );
                          }));
                        },
                        child: Container(
                          height: 50,
                          width: 100,
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
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('Details', style: TextStyle(color: Colors.amber[50], fontFamily: 'Acme', fontSize: 25), textAlign: TextAlign.center,),
                          )
                        ),
                      ),
                    )
                  )
                ],
              )
            )
        ),
    );
  }
}
