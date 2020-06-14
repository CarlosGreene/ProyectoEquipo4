// Main: Envia al usuario a Wrapper cuando inicia el sistema

import 'package:pethouse/screens/home/homeClient/add_event.dart';
import 'package:pethouse/screens/home/wrapper.dart';
import 'package:pethouse/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pethouse/models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.orange,
          primaryIconTheme: IconThemeData(color: Colors.white),
        ),
        home: Wrapper(),
        routes: {
        "add_event": (_) => AddEventPage(),
        },
      ),
    );
  }
}
