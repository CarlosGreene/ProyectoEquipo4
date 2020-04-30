import 'package:flutter/material.dart';
import 'package:pethouse/services/auth.dart';
import 'package:pethouse/services/database.dart';
import 'package:provider/provider.dart';
import 'package:pethouse/screens/home/client-list.dart';
import 'package:pethouse/models/client.dart';

class HomeClient extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Client>>.value(
          value: DatabaseService().client,
          child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('PetHouse'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Cerrar sesión'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        body: UsersList(),       
      ),
    );
  }
}