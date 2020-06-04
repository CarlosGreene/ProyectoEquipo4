import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pethouse/models/user.dart';
import 'package:pethouse/services/database.dart';

class DrawerAdmin extends StatefulWidget {

  final Function signOut;
  final String name;
  final String email;
  DrawerAdmin ({ this.signOut, this.name, this.email });

  @override
  _DrawerAdminState createState() => _DrawerAdminState();
}

class _DrawerAdminState extends State<DrawerAdmin> {
  @override
  Widget build(BuildContext context) {

    int _selectDrawerItem = 0;

    _onSelectedItem(int pos){
      Navigator.of(context).pop();
      setState(() {
      });
    }

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot){
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
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage("https://i.pinimg.com/originals/58/f6/9a/58f69a16b34e9864353070c745bd73b2.jpg")
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
                      _onSelectedItem(0);
                    },
                  ),
                  new ListTile(
                    title: new Text('Volver a Menú de Usuario',
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                    trailing: new Icon(Icons.supervised_user_circle),
                    selected: (3 == _selectDrawerItem),
                    onTap: () async {
                      await DatabaseService (uid: user.uid).updateUserData(userData.name, userData.email, userData.password, !userData.admin);
                    },
                  ),
                  new ListTile(
                    title: new Text('Cerrar Sesión',
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                    trailing: new Icon(Icons.exit_to_app),
                    selected: (4 ==_selectDrawerItem),
                    onTap: () async {
                      await widget.signOut();
                      _onSelectedItem(0);
                    },
                  ),
                ],
            ),
        );
      }
    );
  }
}