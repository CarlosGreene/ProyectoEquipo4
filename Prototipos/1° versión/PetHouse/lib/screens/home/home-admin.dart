import 'package:flutter/material.dart';
import 'package:pethouse/services/auth.dart';
import 'package:table_calendar/table_calendar.dart';

class Todo {
  final String title;
  final String description;

  Todo(this.title, this.description);
}

class HomeAdmin extends StatefulWidget {

  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {

  final AuthService _auth = AuthService();
  
  final todos = List<Todo>.generate(
  20,
  (i) => Todo(
        'Todo $i',
        'Una descripción de lo que se debe hacer para Todo $i',
      ),
  );

  CalendarController _controller;
  Map<DateTime,List<dynamic>> _events;
  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _events = {};
  }

  Map<String,dynamic> encodeMap(Map<DateTime,dynamic> map){
    Map<String,dynamic> newMap = {};
    map.forEach((key,value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime,dynamic> decodeMap(Map<String,dynamic> map){
    Map<DateTime,dynamic> newMap = {};
    map.forEach((key,value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Menú de Administrador',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Cerrar sesión',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return Dismissible(
            // Cada Dismissible debe contener una llave. Las llaves permiten a Flutter
            // identificar de manera única los Widgets.
            key: Key(todos[index].title),
            // También debemos proporcionar una función que diga a nuestra aplicación
            // qué hacer después de que un elemento ha sido eliminado.
            onDismissed: (direction) {
              // Remueve el elemento de nuestro data source.
              setState(() {
                todos.removeAt(index);
              });
            },
            background: Container(color: Colors.red),
            child: ListTile(
              title: Text(todos[index].title),
              // Cuando un usuario pulsa en el ListTile, navega al DetailScreen.
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => view(todos[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
  Widget view(todo) {
    // Usa el objeto Todo para crear nuestra UI
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(todo.description),
            RaisedButton(
              child: Text ('Borrar'),
              onPressed: () async {
                Navigator.pop(context);
              }
            )
          ],
        )
      ),
    );
  }
}


