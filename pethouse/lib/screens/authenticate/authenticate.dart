import 'package:flutter/material.dart';
import 'package:pethouse/screens/authenticate/register.dart';
import 'package:pethouse/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSinIn = true;
  void toggleView() {
    setState(() => showSinIn = !showSinIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSinIn){
      return SingIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}