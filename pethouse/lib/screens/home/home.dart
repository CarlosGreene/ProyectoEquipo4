import 'package:flutter/material.dart';
import 'package:pethouse/screens/authenticate/logAdmin.dart';
import 'package:pethouse/screens/home/home-client.dart';
import 'package:pethouse/models/client.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  final Client client;
  _HomeState({this.client});

  bool showHome = false;
  void changeHome(){
    setState(() {
      showHome = true;
    });
  }

  @override
  Widget build(BuildContext context) {

    if () {
      
    }

    if (client.type) {
      return HomeClient();
    }else{
      return LogAdmin();
    }
  }
}

