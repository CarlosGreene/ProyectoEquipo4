import 'package:flutter/material.dart';
import 'package:pethouse/screens/home/chat.dart';
import 'package:pethouse/screens/home/homeClient/drawer_client.dart';
import 'package:pethouse/screens/home/search.dart';
import 'package:pethouse/services/auth.dart';
import 'package:pethouse/services/database.dart';
import 'package:pethouse/shared/constants.dart';
import 'package:pethouse/shared/helperfunctions.dart';

class MessagesClient extends StatefulWidget {

  final Function changePageClient;
  MessagesClient({ this.changePageClient });

  @override
  _MessagesClientState createState() => _MessagesClientState();
}

class _MessagesClientState extends State<MessagesClient> {

  final AuthService _auth = AuthService();
  DatabaseService databaseMethods = new DatabaseService();

  Stream chatRoomsStream;
  ///Funcion que envia los datos de firebase a la funcion.
  Widget chatRoomList(){
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, snapshot){
        return snapshot.hasData? ListView.builder(
          itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index){
          return ChatRoomsTile(
            snapshot.data.documents[index].data["chatroomId"]
                .toString()
                .replaceAll("_", ""). replaceAll(Constants.myName, ""),
              snapshot.data.documents[index].data["chatroomId"]
          );
        }) : Container();
    },
    );
  }

  void signOut(){
    setState(() async {
      await _auth.signOut();
    });
  }

  void changePage(int page){
    setState(() async {
      await widget.changePageClient(page);
    });
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  ///Funcion que llama a las Chatrooms
  getUserInfo() async{
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    databaseMethods.getChatRooms(Constants.myName).then((value){
      setState(() {
        chatRoomsStream = value;
      });
    });
    setState(() {
    });
  }

  ///Vista principal de pagina y crea el widget de contacto.
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Mensajes"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Search()),///Puente a la pagina search
                );
              }
          ),
        ],
      ),
        body: chatRoomList(),
      drawer: DrawerClient(signOut: signOut, changePage: changePage),
    );
  }

}

class ChatRoomsTile extends StatelessWidget{
  final String userName;
  final String chatRoomId;
  ChatRoomsTile(this.userName, this.chatRoomId);

  @override
Widget build(BuildContext context){///Se crea el cuadro de dialogo para conectarse al chat
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(
          builder: (context) => Chat(chatRoomId)///Funcion para irse al chat
        ));
      },
      child: Container(
        color: Colors.orangeAccent,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(40)
            ),
            child: Text("${userName.substring(0,1).toUpperCase()}"),
          ),
          SizedBox(width: 8,),
          Text(userName)
        ],
        ),
      ),
    );
  }
}