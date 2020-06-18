//SignIn: Modulo que se encarga de iniciar sesión introduciendo los datos de correo y contraseña
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pethouse/services/auth.dart';
import 'package:pethouse/services/database.dart';
import 'package:pethouse/shared/constants.dart';
import 'package:pethouse/shared/helperfunctions.dart';
import 'package:pethouse/shared/loading.dart';

class SignIn extends StatefulWidget {

  //Función toggleView se ubica en authenticate.dart
  final Function toggleView;
  SignIn({ this.toggleView });


  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

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
          //Botón que llama la función toggleView
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
              //El usuario introduce su correo
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Correo'),
                validator: (val) => val.isEmpty ? 'Escribe un correo': null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              //El usuario introduce su contraseña
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Contaseña'),
                //Verifica que la contraseña contenga mínimo 6 caracteres
                validator: (val) => val.length < 6 ? 'Escribe una contraseña con más de 6 caractéres': null,
                obscureText: true,
                onChanged:(val) {
                  setState(() => password = val);
                }
              ),
              SizedBox(height: 20.0),
              //Botón de iniciar sesión
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
                    //Llama la funcion signInWithEmailAndPassword ubicada en auth.dart para buscar la cuenta registrada e iniciar sesión
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