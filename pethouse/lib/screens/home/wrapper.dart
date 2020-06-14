//Wrapper: Se encarga de verificar si el usuario que entró al sistema si tiene una cuenta iniciada 
import 'package:flutter/material.dart';
import 'package:pethouse/screens/authenticate/authenticate.dart';
import 'package:pethouse/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:pethouse/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context); //Usa la clase User del modulo user.dart
    print(user);

    //Te envia a home o a authenticate
    if(user == null)//Verifica si la la clase User es nulo
    {
      return Authenticate();//Si es nulo lo se envia al widget Authenticate del modulo authenticate.dart
    }
    else
    {
      return Home();//Si contiene una id lo envia al widget Home, del modulo home.dart
    }
  }
}