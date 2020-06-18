//Register: modulo que se encarga registrar una cuenta de cliente o de administrador ingresando nombre, correo, y contraseña
import 'package:flutter/material.dart';
import 'package:pethouse/services/auth.dart';
import 'package:pethouse/shared/constants.dart';
import 'package:pethouse/shared/helperfunctions.dart';
import 'package:pethouse/shared/loading.dart';
import '../../services/database.dart';

class Register extends StatefulWidget {

  //Función toggleView se ubica en authenticate.dart
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  bool loading = false;

  final AuthService _auth = AuthService();
  DatabaseService databaseMethods = new DatabaseService();
  HelperFunctions helperFunctions =new HelperFunctions();

  final _formKey = GlobalKey<FormState>();
  String email = '', password = '', name = '', error = '';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.orange[100],
      appBar: AppBar(
        backgroundColor: Colors.orange[400],
        elevation: 0.0,
        title: Text('Registrarse',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        actions: <Widget>[
          //Botón que llama la función toggleView
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Iniciar sesión',
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
              //El usuario introduce su nombre completo
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Nombre completo'),
                validator: (val) => val.isEmpty ? 'Escribe tu nombre completo':  null,
                onChanged: (val) {
                  setState(() => name = val);
                },
              ),
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
                decoration: textInputDecoration.copyWith(hintText: 'Contraseña'),
                obscureText: true,
                //Verifica que la contraseña contenga mínimo 6 caracteres
                validator: (val) => val.length < 6 ? 'Escribe una contraseña con más de 6 caractéres': null,
                onChanged:(val) {
                  setState(() => password = val);
                }
              ),
              SizedBox(height: 20.0),
              //Botón para registrarse como cliente
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Registrarse',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){

                    Map<String, String> userMap = {
                      "name": name,
                      "email": email
                    };

                    HelperFunctions.saveUserNameSharedPreference(name);
                    HelperFunctions.saveUserEmailSharedPreference(email);
                    ///Guarda las prefencias de las variables

                    setState(() => loading = true);
                    //Llama la funcion signInWithEmailAndPasswordClient ubicada en auth.dart para registrar cuenta como cliente
                    dynamic result = await _auth.registerWithNameEmailAndPasswordClient(name, email, password);

                    databaseMethods.uploadUserInfo(userMap);
                    HelperFunctions.saveUserLoggedInSharedPreference(true);
                    ///Guarda las prefencia
                    if(result == null){
                      setState(() { 
                        error = 'Por favor, escribe un correo válido';
                        loading = false;
                      });
                    }
                  }
                },               
              ),
              SizedBox(height: 20.0),
              //Botón para registrarse como adminstrador
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Registrarse como adminstrador',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){

                    Map<String, String> userMap = {
                      "name": name,
                      "email": email
                    };

                    setState(() => loading = true);
                    //Llama la funcion signInWithEmailAndPasswordAdmin ubicada en auth.dart para registrar cuenta como adminstrador
                    dynamic result = await _auth.registerWithEmailAndPasswordAdmin(name, email, password);

                    databaseMethods.uploadUserInfo(userMap);
                    HelperFunctions.saveUserLoggedInSharedPreference(true);
                    HelperFunctions.saveUserNameSharedPreference(name);
                    HelperFunctions.saveUserEmailSharedPreference(email);
                ///Guarda las prefencias de las variables

                    if(result == null){
                      setState(() { 
                        error = 'Por favor, escribe un correo válido';
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