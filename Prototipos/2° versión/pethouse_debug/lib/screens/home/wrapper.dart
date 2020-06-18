import 'package:flutter/material.dart';
import 'package:pethouse/screens/authenticate/authenticate.dart';
import 'package:pethouse/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:pethouse/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);

    //Te envia a home o a authenticate
    if(user == null)
    {
      return Authenticate();
    }
    else
    {
      return Home();
    }
  }
}