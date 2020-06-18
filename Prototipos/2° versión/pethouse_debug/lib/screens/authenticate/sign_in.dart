import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pethouse/services/auth.dart';
import 'package:pethouse/services/database.dart';
import 'package:pethouse/shared/constants.dart';
import 'package:pethouse/shared/helperfunctions.dart';
import 'package:pethouse/shared/loading.dart';

class SingIn extends StatefulWidget {

  final Function toggleView;
  SingIn({ this.toggleView });


  @override
  _SingInState createState() => _SingInState();
}

class _SingInState extends State<SingIn> {

  final AuthService _auth = AuthService();
  DatabaseService databaseMethods = new DatabaseService();
  final _formKey = GlobalKey<FormState>();
  HelperFunctions helperFunctions =new HelperFunctions();
  bool loading = false;
  QuerySnapshot snapshotUserInfo;
  String email = '', password = '', error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.orange[100],
      appBar: AppBar(
        backgroundColor: Colors.orange[400],
        elevation: 0.0,
        title: Text('Iniciar sesión',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Registrarse',
              style: TextStyle(
                color: Colors.white
              ),
            ),
            onPressed: () {
              widget.toggleView();
            }
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget> [
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Correo'),
                validator: (val) => val.isEmpty ? 'Escribe un correo': null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Contaseña'),
                validator: (val) => val.length < 6 ? 'Escribe una contraseña con más de 6 caractéres': null,
                obscureText: true,
                onChanged:(val) {
                  setState(() => password = val);
                }
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Iniciar sesión',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    HelperFunctions.saveUserEmailSharedPreference(email);
                    databaseMethods.getUserByUserEmail(email).then ((result){
                      snapshotUserInfo = result;
                      HelperFunctions.saveUserNameSharedPreference(snapshotUserInfo.documents[0].data["name"]);
                    });///Guarda las preferencias dentro de sus funciones

                    setState(() { 
                      loading = true; 
                    });

                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);

                    if(result == null){

                      HelperFunctions.saveUserLoggedInSharedPreference(true);
                      setState(() { ///Guarda las preferencias
                        error = 'Por favor, escribe un correo y/o contraseña válidos'; 
                        loading = false;
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ]
          ),
        ),
      ),
    );
  }
}
