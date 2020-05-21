import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pethouse/models/client.dart';

class DatabaseService{

  final String uid;
  DatabaseService({ this.uid });

  //Colección de referencias
  final CollectionReference clientCollection = Firestore.instance.collection('client');

  Future updateUserData(String animal, int age, bool type) async {
    return await clientCollection.document(uid).setData({
      'animal' : animal,
      'age' : age,
      'type': type,
    });
  }

  //Lista Client snapshot
  List<Client> _clientListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Client(
        animal: doc.data['animal'] ?? '',
        age: doc.data['age'] ?? 0,
        type: doc.data['type'] ?? false,
      );
    }).toList();
  }

  Stream<List<Client>> get client {
    return clientCollection.snapshots()
      .map(_clientListFromSnapshot);
  }
}