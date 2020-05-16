import 'package:flutter/material.dart';
import 'package:pethouse/screens/home/home-admin.dart';
import 'package:pethouse/services/auth.dart';
import 'package:pethouse/shared/constants.dart';
import 'package:pethouse/shared/loading.dart';

class HomeClient extends StatefulWidget {

  @override
  _HomeClientState createState() => _HomeClientState();
}

class _HomeClientState extends State<HomeClient> {

  final AuthService _auth = AuthService();
  
  String password = '';
  bool loading = false;

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
          IconButton(
            icon: Icon(Icons.assignment_ind), 
            onPressed: logAdmin,
          )
        ],
      ),
      body: Container(
        child: Text('Eres cliente'),
      ),
    );
  }

  void logAdmin(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      final _formKey = GlobalKey<FormState>();
      return loading ? Loading() : Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Entrar como administrador'),
          backgroundColor: Colors.brown[400],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 12.0),
                Text('Introduce la clave para entrar como Administrador. Cuando le des a verificar sal, si la interfaz cambió, significa que entraste a administrador'),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Clave para administrador'),
                  obscureText: true,
                  validator: (val) => val.length < 1 ? 'Por favor escribe la clave': null,
                  onChanged:(val) {
                    setState(() => password = val);
                  }
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Verificar',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      if (password == 'prototipo2020') {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeAdmin()),);
                      } else {
                      }
                    } 
                  },
                ),
              ]
            ),
          ), 
        ),
      );
    }));
  }
}

