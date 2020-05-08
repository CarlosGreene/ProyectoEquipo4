import 'package:flutter/material.dart';
import 'package:pethouse/services/auth.dart';

class HomeAdmin extends StatefulWidget {

  final Function changeHome;
  HomeAdmin ({this.changeHome});

  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          FlatButton.icon(
            icon: Icon(Icons.arrow_back),
            label: Text('regresar'),
            onPressed: () {
              widget.changeHome();
            }
          )
        ],
      ),
      body: Container(
        child: Text('Eres Administrador'),
      ),
    );
  }
}