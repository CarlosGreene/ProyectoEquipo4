import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;
  DatabaseService({ this.uid });

  //Colección de referencias
  final CollectionReference clientCollection = Firestore.instance.collection('client');

  Future updateUserData(String animal, int age) async {
    return await clientCollection.document(uid).setData({
      'animal' : animal,
      'age' : age,
    });
  }
}