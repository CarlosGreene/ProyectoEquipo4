import 'package:flutter/material.dart';
import 'package:pethouse/screens/home/logAdmin.dart';
import 'package:pethouse/screens/home/home-client.dart';


class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  bool aux= true;
  void changeHome(){
    setState(() => aux = !aux);
  }

  @override
  Widget build(BuildContext context) {

    if (aux) {
      return HomeClient(changeHome: changeHome);
    }else{
      return LogAdmin(changeHome: changeHome);
    }
  }
}

