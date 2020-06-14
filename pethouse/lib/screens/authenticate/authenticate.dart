// authenticate: modulo que te envia a iniciar sesión o registrarse
import 'package:flutter/material.dart';
import 'package:pethouse/screens/authenticate/register.dart';
import 'package:pethouse/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  //toggleView: Función que cambia el valor de showSignIn
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    //Dependiendo del valor de showSignIn, te envia a SignIn o a Register
    if (showSignIn){
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}