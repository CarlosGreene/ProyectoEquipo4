
import 'package:flutter/material.dart';
import 'package:pethouse/screens/chatRoom/Imagenes.dart';
import 'package:pethouse/services/database.dart';
import 'package:pethouse/shared/constants.dart';

class Chat extends StatefulWidget {

 final String chatRoomId;
 Chat(this.chatRoomId);


  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  DatabaseService databaseMethods = new DatabaseService();
  TextEditingController messageController = new TextEditingController();

  Stream chatMessagesStream;

  ///Muestra los mensajes guardados de la base de datos
  Widget chatMessageList(){
  return StreamBuilder(
    stream: chatMessagesStream,
    builder: (context, snapshot){
      return snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index){
            return MessageTile(snapshot.data.documents[index].data["message"],
                snapshot.data.documents[index].data["sendBy"]== Constants.myName);
          }) : Container();
    },
  );
  }

  ///Guarda el mensaje directamente en la base de datos
  sendMessage(){
    if(messageController.text.isNotEmpty){
      Map<String,dynamic> messageMap = {
        "message" : messageController.text,
        "sendBy" : Constants.myName,
        "time" : DateTime.now().millisecondsSinceEpoch
      };
      databaseMethods.addConversationMessages(widget.chatRoomId,messageMap);
      messageController.text = "";
    }
}

///Guarda el valor del mensaje dentro de la variable
  @override
  void initState() {
    databaseMethods.getConversationMessages(widget.chatRoomId).then((value){
      setState(() {
        chatMessagesStream = value;
      });
    });
    super.initState();
  }

  ///Vista principal de la pagina de Chats
  @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: <Widget>[IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: (){Navigator.push(context,
              MaterialPageRoute(builder: (context) => Imagenes()),
            );}
        ),],
      ),
      body: Container(
        child:Stack(
          children: [
            chatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    color: Color(0xFFFB8C00),
                    child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller:messageController,
                              style: TextStyle(),
                              decoration: InputDecoration(
                                  hintText: "Mensaje...",
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              sendMessage();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.deepOrange[300],
                                  borderRadius: BorderRadius.circular(24)
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              child: Text("Go!",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16
                                ),),
                          )
                          )
                        ]
                    ),
                  ),
            )
                ],
              ),

        )
      );

  }
}

///Vista de los mensajes que estan guardados en la base de datos.
class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  MessageTile(this.message, this.isSendByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: isSendByMe ? 0: 24, right: isSendByMe ? 24 : 0),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSendByMe ? [
              const Color(0xFFFF9800),
              const Color(0xFFF57C00)
            ]
                : [
                  const Color(0xFFF57C00),
                  const Color(0xFFFF9800)
            ],
          ),
          borderRadius: isSendByMe ?
              BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23)
              ):
              BorderRadius.only(
              topLeft: Radius.circular(23),
              topRight: Radius.circular(23),
              bottomRight: Radius.circular(23))
        ),
        child: Text(message, style: TextStyle(
          color: Colors.black,
          fontSize: 17
        ),
          ) ,
      ),
    );
  }
}
