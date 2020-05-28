import 'package:flutter/material.dart';
//import 'package:pethouse/screens/home/home-admin.dart';
import 'package:pethouse/services/auth.dart';
import 'package:pethouse/services/database.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:pethouse/models/user.dart';
import 'package:provider/provider.dart';

class HomeClient extends StatefulWidget {

  final Function changeHome;
  HomeClient ({ this.changeHome });

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

    _onSelectedItem(int pos){
      Navigator.of(context).pop();
      setState(() {
      });
    }

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        UserData userData = snapshot.data;
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
                    accountName: new Text(userData.name,
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    accountEmail: new Text(userData.email,
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
                      widget.changeHome();
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
    );
  }
}

