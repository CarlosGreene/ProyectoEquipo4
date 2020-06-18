import 'package:flutter/material.dart';
import 'package:pethouse/screens/home/homeClient/about_us.dart';
import 'package:pethouse/screens/home/homeAdmin/calendar_admin.dart';
import 'package:pethouse/screens/home/logAdmin.dart';
import 'package:pethouse/screens/home/homeClient/calendar_client.dart';
import 'package:pethouse/models/user.dart';
import 'package:provider/provider.dart';
import 'package:pethouse/services/database.dart';
import 'package:pethouse/screens/home/homeClient/messages_client.dart';
import 'package:pethouse/screens/home/homeAdmin/messages_admin.dart';
import 'package:pethouse/screens/home/homeClient/need_help.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  bool aux = true;
  void goAdmin(){
    setState(() => aux = !aux);
  }

  int pageClient = 0;
  void changePageClient(int change1){
    setState(() => pageClient = change1);
  }

  int pageAdmin = 0;
  void changePageAdmin(int change2){
    setState(() => pageAdmin = change2);
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot){
        UserData userData = snapshot.data;
        if (userData.admin==true) { 
          switch (pageClient) {
            case  0: 
              return HomeClient(changePageClient: changePageClient);
              break;
            
            case 1:
              return MessagesClient(changePageClient: changePageClient);
              break;

            case 2:
              return AboutUs(changePageClient: changePageClient);
              break;

            case 3:
              return NeedHelp(changePageClient: changePageClient);
              break;

            default:
          }
          
        } else if (aux==true) {
          return LogAdmin(goAdmin: goAdmin);
        } else {
          switch (pageAdmin) {
            case 0:
              return CalendarAdmin(goAdmin: goAdmin, changePageAdmin: changePageAdmin);
              break;

            case 1:
              return MessagesAdmin(changePageAdmin: changePageAdmin);
              break;

            default:
          }
        }
      }
    );
  }  

}

