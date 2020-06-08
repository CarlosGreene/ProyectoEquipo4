import 'package:flutter/material.dart';
import 'package:pethouse/screens/home/homeAdmin/drawer_admin.dart';
import 'package:pethouse/services/auth.dart';

class MessagesAdmin extends StatefulWidget {

  final Function changePageAdmin;
  MessagesAdmin({ this.changePageAdmin });

  @override
  _MessagesAdminState createState() => _MessagesAdminState();
}

class _MessagesAdminState extends State<MessagesAdmin> {

  final AuthService _auth = AuthService();

  void signOut(){
    setState(() async {
      await _auth.signOut();
    });
  }

  void changePage(int page){
    setState(() async {
      await widget.changePageAdmin(page);
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Mensajes"),
      ),
      drawer: DrawerAdmin(signOut: signOut, changePage: changePage),
    );
  }

}