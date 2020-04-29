import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;
  DatabaseService( { this.uid});

  //Colección de referencias
  final CollectionReference brewCollection = Firestore.instance.collection('brews');

  Future updateUserData(String name) async {
    return await brewCollection.document(uid).setData({
      'name' : name,
    });
  }
}