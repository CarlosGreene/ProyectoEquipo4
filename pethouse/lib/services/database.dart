//database: Modulo que se encarga de guardar los datos de los usarios registrados, como el nombre, correo, etc.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pethouse/models/client.dart';
import 'package:pethouse/models/user.dart';

class DatabaseService{

  final String uid;
  DatabaseService({ this.uid });

  //Colección de referencias
  final CollectionReference clientCollection = Firestore.instance.collection('clients');

  Future updateUserData(String name, String email, String password, bool admin) async {
    return await clientCollection.document(uid).setData({
      'name' : name,
      'email' : email,
      'password' : password,
      'admin' : admin
    });
  }

  //Lista Client snapshot
  List<Client> _clientListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Client(
        name: doc.data['name'] ?? '',
        email: doc.data['email'] ?? '',
        password: doc.data['password'] ?? '',
        admin: doc.data['admin'] ?? false,
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
      admin: snapshot.data['admin'],
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

  ///Muestra el username para guardarlo dentro de HelperFuntions.
  getUserByUsername(String name) async {
    return await Firestore.instance
        .collection("clients")
        .where('name', isEqualTo: name)
        .getDocuments();
  }

///Muestra el Mapa de clients
  uploadUserInfo(userMap) async {
    Firestore.instance.collection("clients")
        .add(userMap).catchError((e) {
      print(e.toString());
    });
  }


///Muestra el Email para guardarlos de HelperFunctions
  getUserByUserEmail(String email) async {
    return Firestore.instance
        .collection("clients")
        .where("email", isEqualTo: email)
        .getDocuments();
    }


///Crea un sala de chat dependiendo del id del usuario
  createChatRoom(String charRoomId, chatRoomMap) {
    Firestore.instance
        .collection("ChatRoom")
        .document(charRoomId)
        .setData(chatRoomMap)
        .catchError((e) {
      print(e);
    });
  }

  ///Muestra la lo que escribe el usuario
  getConversationMessages(String chatRoomId)  async{
    return await Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy("time",descending: false)
        .snapshots();
  }

///Obtiene las conversaciones de los chats.
  addConversationMessages(String chatRoomId,messageMap ) {
    Firestore.instance.collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(messageMap).catchError((e) {
      print(e.toString());
    });
  }

  ///Muestra el lista de los chats.
  getChatRooms(String userName) async {
    return await Firestore.instance
        .collection("ChatRoom")
        .where('users', arrayContains: userName)
        .snapshots();
  }
}