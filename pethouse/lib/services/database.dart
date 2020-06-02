import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pethouse/models/client.dart';
import 'package:pethouse/models/user.dart';

class DatabaseService{

  final String uid;
  DatabaseService({ this.uid });

  //Colección de referencias
  final CollectionReference clientCollection = Firestore.instance.collection('clients');

  Future updateUserData(String name, String email, String password, bool client) async {
    return await clientCollection.document(uid).setData({
      'name' : name,
      'email' : email,
      'password' : password,
      'client' : client
    });
  }

  //Lista Client snapshot
  List<Client> _clientListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Client(
        name: doc.data['name'] ?? '',
        email: doc.data['email'] ?? '',
        password: doc.data['password'] ?? '',
        client: doc.data['client'] ?? false,
      );
    }).toList();
  }

  //UserData de snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      email: snapshot.data['email'],
      password: snapshot.data['password'],
      client: snapshot.data['client'],
    );
  }

  Stream<List<Client>> get clients {
    return clientCollection.snapshots()
      .map(_clientListFromSnapshot);
  }

  //Conseguir los datos del usuario
  Stream<UserData> get userData {
    return clientCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }
}