//client_admin: genera una interfaz en forma de tabla de calendario, donde se representan de manera gráfica todos los "eventos" guardados en 
//la base de datos
import 'package:flutter/material.dart';
import 'package:pethouse/screens/home/homeClient/drawer_client.dart';
import 'package:pethouse/services/auth.dart';
import 'package:pethouse/services/database.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:pethouse/models/user.dart';
import 'package:provider/provider.dart';
import 'package:pethouse/models/event.dart';
import 'package:pethouse/red/event_firestore_service.dart';
import 'package:pethouse/screens/home/homeClient/view_client.dart';

class HomeClient extends StatefulWidget {
  
  final Function changePageClient;
  HomeClient({ this.changePageClient });

  @override
  _HomeClientState createState() => _HomeClientState();
}

class _HomeClientState extends State<HomeClient> {

  final AuthService _auth = AuthService();
  
  CalendarController _controller;
  Map<DateTime,List<dynamic>> _events;
  List<dynamic>_selectedEvents;
  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _events = {};
    _selectedEvents = [];
  }

  void signOut(){
    setState(() async {
      await _auth.signOut();
    });
  }

  void changePage(int page){
    setState(() async {
      await widget.changePageClient(page);
    });
  }

  Map<DateTime, List<dynamic>> _groupEvents(List<EventModel> allEvents) {
    Map<DateTime, List<dynamic>> data = {};
    allEvents.forEach((event) {
      DateTime date = DateTime(
          event.eventDate.year, event.eventDate.month, event.eventDate.day, 12);
      if (data[date] == null) data[date] = [];
      data[date].add(event);
    });
    return data;
  }
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
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
          drawer: DrawerClient(signOut: signOut, changePage: changePage),
          body: StreamBuilder<List<EventModel>>(
          stream: eventDBS.streamList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<EventModel> allEvents = snapshot.data;
              if (allEvents.isNotEmpty) {
                _events = _groupEvents(allEvents);
              } else {
                _events = {};
                _selectedEvents = [];
              }
            }
            return SingleChildScrollView(
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
                        color: Colors.pink[200],
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      formatButtonTextStyle: TextStyle(
                        color: Colors.white,
                      ),
                      formatButtonShowsNext: false,
                    ),
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    onDaySelected: (date, events) {
                      setState(() {
                        _selectedEvents = events;
                      });
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
                  ),
                  ..._selectedEvents.map((event) => ListTile(
                    title: Text(event.title),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EventDetailsPage(
                            event: event,
                          ) 
                        ) 
                      );
                    },
                  )),
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, 'add_event'),
      ),
        );
      }
    );
  }
}

