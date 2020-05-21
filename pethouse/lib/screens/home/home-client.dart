//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pethouse/screens/home/home-admin.dart';
import 'package:pethouse/services/auth.dart';
import 'package:pethouse/shared/constants.dart';
import 'package:pethouse/shared/loading.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:pethouse/models/user.dart';

class HomeClient extends StatefulWidget {
  @override
  _HomeClientState createState() => _HomeClientState();
}

class _HomeClientState extends State<HomeClient> {

  final AuthService _auth = AuthService();
  
  String password = '';
  bool loading = false;

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
    int _selectDrawerItem = 0;
    final userName = Provider.of<UserName>(context);

    _onSelectedItem(int pos){
      Navigator.of(context).pop();
      setState(() {
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Menú de Usuario',
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.right
        ),
      ),
      drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text("Ángel González",
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                accountEmail: new Text("aagl2306@gmail.com",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0
                  ),
                ),
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new NetworkImage("https://i.pinimg.com/originals/58/f6/9a/58f69a16b34e9864353070c745bd73b2.jpg")
                  )
                ),
              ),
              new ListTile(
                title: new Text('Calendario',
                  style: TextStyle(
                    fontSize: 20.0
                  ),
                ),
                trailing: new Icon(Icons.calendar_today),
                selected: (1 == _selectDrawerItem),
                onTap: (){
                  _onSelectedItem(0);
                },
              ),
              new ListTile(
                title: new Text('Mensajes',
                  style: TextStyle(
                    fontSize: 20.0
                  ),
                ),
                trailing: new Icon(Icons.message),
                selected: (2 == _selectDrawerItem),
                onTap: (){
                  _onSelectedItem(0);
                },
              ),
              new ListTile(
                title: new Text('Acerca de nosotros',
                  style: TextStyle(
                    fontSize: 20.0
                  ),
                ),
                trailing: new Icon(Icons.person),
                selected: (3 == _selectDrawerItem),
                onTap: (){
                  _onSelectedItem(0);
                }
              ),
              new ListTile(
                title: new Text('Necesito ayuda',
                  style: TextStyle(
                    fontSize: 20.0
                  ),
                ),
                trailing: new Icon(Icons.help),
                selected: (4 == _selectDrawerItem),
                onTap: (){
                  _onSelectedItem(0);
                },
              ),
              new ListTile(
                title: new Text('Iniciar como Administrador',
                  style: TextStyle(
                    fontSize: 20.0
                  ),
                ),
                trailing: new Icon(Icons.pageview),
                selected: (5 == _selectDrawerItem),
                onTap: () async {
                  userName.type = !userName.type;
                }
              ),
              new ListTile(
                title: new Text('Cerrar Sesión',
                  style: TextStyle(
                    fontSize: 20.0
                  ),
                ),
                trailing: new Icon(Icons.exit_to_app),
                selected: (6 ==_selectDrawerItem),
                onTap: () async {
                  await _auth.signOut();
                  _onSelectedItem(0);
                },
              ),
            ],
        ),
      ),
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              events: _events,
              initialCalendarFormat: CalendarFormat.month,
              calendarStyle: CalendarStyle(
                todayColor: Colors.red[300],
                selectedColor: Theme.of(context).primaryColor,
                todayStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white,
                )
              ),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.red[300],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(
                  color: Colors.white,
                ),
                formatButtonShowsNext: false,
              ),
              onDaySelected: (date, events){
                print(date.toIso8601String());
              },
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) => 
                Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle
                  ),
                  child: Text(date.day.toString(),
                  style: TextStyle(
                    color: Colors.white
                  ),
                  )
                ),
                todayDayBuilder: (context, date, events) =>
                Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.red[200],
                    shape: BoxShape.circle
                  ),
                  child: Text(date.day.toString(),
                  style: TextStyle(
                    color: Colors.white
                  ),
                  )
                )
              ),
              calendarController: _controller,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){},
      ),
    );
  }

  void loAdmin(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      final _formKey = GlobalKey<FormState>();
      return loading ? Loading() : Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Entrar como administrador'),
          backgroundColor: Colors.brown[400],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 12.0),
                Text('Introduce la clave para entrar como Administrador. Cuando le des a verificar sal, si la interfaz cambió, significa que entraste a administrador'),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Clave para administrador'),
                  obscureText: true,
                  validator: (val) => val.length < 1 ? 'Por favor escribe la clave': null,
                  onChanged:(val) {
                    setState(() => password = val);
                  }
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Verificar',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      if (password == 'prototipo2020') {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeAdmin()),);
                      }
                    } 
                  },
                ),
              ]
            ),
          ), 
        ),
      );
    }));
  }
}

