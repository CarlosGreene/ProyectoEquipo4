import 'package:flutter/material.dart';
import 'package:pethouse/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:pethouse/models/user.dart';
import 'package:pethouse/services/database.dart';

class DrawerAdmin extends StatefulWidget {

  final Function signOut;
  final Function changePage;
  DrawerAdmin ({ this.signOut, this.changePage });

  @override
  _DrawerAdminState createState() => _DrawerAdminState();
}

class _DrawerAdminState extends State<DrawerAdmin> {

  @override
  Widget build(BuildContext context) {

    int _selectDrawerItem = 0;

    _onSelectedItem(int pos){
      _selectDrawerItem = pos;
      Navigator.of(context).pop();
      setState(() async{
        await widget.changePage(_selectDrawerItem);
      });
    }

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot){
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
        return Drawer(
          child: new ListView(
                children: <Widget>[
                  new UserAccountsDrawerHeader(
                    accountName: new Text(userData.name,
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    accountEmail: new Text(userData.email,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0
                      ),
                    ),
                    currentAccountPicture: new GestureDetector(
                      onTap: () => print("imagen actual"),
                      child: new CircleAvatar(
                        backgroundImage: AssetImage("assets/DefaultAvatar.jpg")
                        ),
                      ),
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/Banner.jpg")
                      )
                    ),
                  ),
                  new ListTile(
                    title: new Text('Calendario',
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                    trailing: new Icon(Icons.calendar_today),
                    selected: (1 == _selectDrawerItem),
                    onTap: (){
                      _onSelectedItem(0);
                    },
                  ),
                  new ListTile(
                    title: new Text('Mensajes',
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                    trailing: new Icon(Icons.message),
                    selected: (2 == _selectDrawerItem),
                    onTap: (){
                      _onSelectedItem(1);
                    },
                  ),
                  new ListTile(
                    title: new Text('Cerrar Sesión',
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                    trailing: new Icon(Icons.exit_to_app),
                    selected: (3 ==_selectDrawerItem),
                    onTap: () async{
                      await widget.signOut();
                      await DatabaseService (uid: user.uid).updateUserData(
                        userData.name, 
                        userData.email, 
                        userData.password, 
                        !userData.admin);
                      _onSelectedItem(0);
                    },
                  ),
                ],
            ),
        );
        } else {
        }
        return Loading();
      }
    );
  }
}