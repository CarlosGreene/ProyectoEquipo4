import 'package:flutter/material.dart';
import 'package:pethouse/screens/home/logAdmin.dart';
import 'package:pethouse/screens/home/home-client.dart';
import 'package:pethouse/models/user.dart';
import 'package:provider/provider.dart';
import 'package:pethouse/services/database.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  bool aux = true;
  void changeHome(){
    setState(() => aux = !aux);
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot){
        UserData userData = snapshot.data;
          if (userData.client==false) {  
            return HomeClient(changeHome: changeHome);
          }else{
            return LogAdmin(changeHome: changeHome);
        }
      }
    );
  }  

}

