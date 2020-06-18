import 'package:flutter/material.dart';
import 'package:pethouse/screens/home/homeClient/drawer_client.dart';
import 'package:pethouse/services/auth.dart';

class NeedHelp extends StatefulWidget {

  final Function changePageClient;
  NeedHelp({ this.changePageClient });

  @override
  _NeedHelpState createState() => _NeedHelpState();
}

class _NeedHelpState extends State<NeedHelp> {

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Necesito ayuda"),
      ),
      drawer: DrawerClient(signOut: signOut, changePage: changePage),
    );
  }
}
