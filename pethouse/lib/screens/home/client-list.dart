import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pethouse/models/client.dart';

class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {

    final client = Provider.of<List<Client>>(context);
    client.forEach((client) {
      print(client.name);
      print(client.age);
    });

    return Container(
      child: Text('Eres cliente'),
    );
  }
}