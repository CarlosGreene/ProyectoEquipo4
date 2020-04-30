import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pethouse/models/client.dart';

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

  //Client linst from snapshot
  List<Client> _clientListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return Client(
        name: doc.data['name'] ?? '',
        age: doc.data['age'] ?? 0,
      );
    }).toList();
  }

  Stream<List<Client>> get client {
    return clientCollection.snapshots()
      .map(_clientListFromSnapshot);
  }
}