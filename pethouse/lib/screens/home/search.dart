import 'package:pethouse/screens/home/chat.dart';
import 'package:pethouse/shared/constants.dart';
import 'package:pethouse/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}
String _myName;

class _SearchState extends State<Search> {

  DatabaseService databaseMethods = new DatabaseService();
  TextEditingController searchEditingController = new TextEditingController();
  QuerySnapshot searchSnapshot;



  bool loading = false;
  bool haveUserSearched = false;

///Funcion que imprime donde esta guardado los datos del email y name.
  Widget searchList() {
    return searchSnapshot != null ? ListView.builder(
        shrinkWrap: true,
        itemCount: searchSnapshot.documents.length,
        itemBuilder: (context, index) {
          return searchTile(
            name: searchSnapshot.documents[index].data["name"],
            email: searchSnapshot.documents[index].data["email"],);
        }
    ) :Container();
  }

///Funcion que compara el texto con lo que existe en la base de datos.
  initiateSearch() async {
    if (searchEditingController.text.isNotEmpty) {
      setState(() {
        loading = true;
      });
      await databaseMethods
          .getUserByUsername(searchEditingController.text)
          .then((val) {
        searchSnapshot = val;
        print("$searchSnapshot");
        setState(() {
          loading = false;
          haveUserSearched = true;
        });
      });
    }
  }





  /// Crea un sala de chat, envia al usuario a la sala.
  createChatroomAndStartConversation({String name}) {
    
    print("${Constants.myName}");
    if (name != Constants.myName) {
      String chatRoomId = getChatRoomId(Constants.myName, name);

      List<String> users = [name, Constants.myName];

      Map<String, dynamic> charRoomMap = {
        "users": users,
        "chatroomId": chatRoomId,
      };
      DatabaseService().createChatRoom(chatRoomId, charRoomMap);
      Navigator.push(context, MaterialPageRoute(
          builder: (context) =>
              Chat(chatRoomId)
      ));
    }else{
      print("No puedes enviarte mensaje a ti mismo");
    }
  }

  ///Vista del nombre y email de suario, y el boton Mensaje
  Widget searchTile({String name, String email}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(color: Colors.black, fontSize: 16),),
              Text(email, style: TextStyle(color: Colors.black, fontSize: 16),)
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              createChatroomAndStartConversation(name:name);
            },
            child:Container(
              decoration: BoxDecoration(
                  color: Colors.deepOrange[400],
                  borderRadius: BorderRadius.circular(24)
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text("Message",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                ),),
            ),
          )
        ],
      ),
    );
  }

  ///Crea el dialogo de mensaje
  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  void initState() {
    super.initState();
  }

  ///Vista del ApppBar principal de pagina y control para la busqueda del usuario por su nombre.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search by username'),
      ),
      body: loading ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) :
      Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              color: Color(0xFFFB8C00),
              child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchEditingController,
                        style: TextStyle(),
                        decoration: InputDecoration(
                            hintText: "search username ...",
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            border: InputBorder.none
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        initiateSearch();
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24)
                          ),
                          child: Text("Search",
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 16),
                          )
                      ),
                    )
                  ]
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }
}


