
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  final _fireStoreInstance = Firestore.instance;

  var _beers; 

  FireStoreService() {
    _beers = _fireStoreInstance.collection('Beers');
  }
  
  get Beers => _beers; 

}