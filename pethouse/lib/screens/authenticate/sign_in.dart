import 'package:flutter/material.dart';
import 'package:pethouse/services/auth.dart';

class SingIn extends StatefulWidget {
  @override
  _SingInState createState() => _SingInState();
}

class _SingInState extends State<SingIn> {

  final AuthService _auth = AuthService();
  
  //estado del campo de texto
  String email = '', password = '', error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Iniciar sesión'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          child: Column(
            children: <Widget> [
              SizedBox(height: 20.0,),
              TextFormField(
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
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
                  print(email);
                  print(password);
                },
              ),
            ]
          ),
        ),
      ),
    );
  }
}