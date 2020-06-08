import 'package:flutter/material.dart';
import 'package:pethouse/screens/home/homeClient/drawer_client.dart';
import 'package:pethouse/services/auth.dart';

class MessagesClient extends StatefulWidget {

  final Function changePageClient;
  MessagesClient({ this.changePageClient });

  @override
  _MessagesClientState createState() => _MessagesClientState();
}

class _MessagesClientState extends State<MessagesClient> {

  final AuthService _auth = AuthService();

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
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Mensajes"),
      ),
      drawer: DrawerClient(signOut: signOut, changePage: changePage),
    );
  }

}