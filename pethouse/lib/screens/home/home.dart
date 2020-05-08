import 'package:flutter/material.dart';
import 'package:pethouse/screens/home/home-admin.dart';
import 'package:pethouse/screens/home/home-client.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool showHome = true;
  void changeHome() {
    setState(() => showHome = !showHome);
  }

  @override
  Widget build(BuildContext context) {
    if (showHome){
      return HomeClient(changeHome: changeHome);
    } else {
      return HomeAdmin(changeHome: changeHome);
    }
  }
}