import 'package:flutter/material.dart';
import 'package:pethouse/screens/home/homeClient/drawer_client.dart';
import 'package:pethouse/services/auth.dart';

class AboutUs extends StatefulWidget {

  final Function changePageClient;
  AboutUs({ this.changePageClient });

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {

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
        title: Text("Acerca de Nosotros"),
      ),
      drawer: DrawerClient(signOut: signOut, changePage: changePage),
    );
  }

}

