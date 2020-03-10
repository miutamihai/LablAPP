import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  final _fireStoreInstance = Firestore.instance;

  var _beers;
  var _users;

  FireStoreService() {
    print('beer collection initialised');
    _beers = _fireStoreInstance.collection('Beers');
    print('user collection initialised');
    _users = _fireStoreInstance.collection('Users');
  }
  
  get Beers => _beers; 
  get Users => _users;
}