import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:pethouse/models/event.dart';
import 'package:pethouse/services/eventDB.dart';

class EventDetailsAdmin extends StatefulWidget {
  final EventModel event;
  const EventDetailsAdmin({Key key, this.event}) : super(key: key);

  @override
  _EventDetailsAdminState createState() => _EventDetailsAdminState();
}

class _EventDetailsAdminState extends State<EventDetailsAdmin> {

  DateTime _date;
  TimeOfDay _time;


  @override
  void initState() {
    super.initState();
    _date = DateTime.now();
    _time = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Descripción de la cita'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(widget.event.title, style: Theme.of(context).textTheme.display1,),
            SizedBox(height: 20.0),
            Text(widget.event.pNumber, style: TextStyle(fontSize: 20)),
            SizedBox(height: 10.0),
            Text(widget.event.mail, style: TextStyle(fontSize: 20)),
            SizedBox(height: 10.0),
            Text(formatDate(widget.event.eventDate,[dd,'/',mm,'/',yyyy,'    ',hh,':',nn,'  ',am]), style: TextStyle(fontSize: 20)),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 3.0),),
            new RaisedButton(
              color: Colors.pink[300],
              splashColor: Colors.orange[300],
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Text("Cambiar Fecha"),
              onPressed:()async{
                  DateTime picked = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: DateTime(_date.year-5), 
                    lastDate: DateTime(_date.year+5));

                    if(picked != null) {
                      setState(() {
                        _date = picked;
                    });
                  TimeOfDay t = await showTimePicker(
                    context: context, 
                    initialTime: _time
                    );

                    if(t != null)
                      setState(() {
                        _time = t;
                      });
                }
                var dateTime = DateTime(_date.year, _date.month, _date.day, _time.hour, _time.minute );
                print(dateTime);
                await eventDBS.updateData(widget.event.id,{
                  'event_date': dateTime
                });
                Navigator.pop(context);
              }
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),),
            new RaisedButton(
              color: Colors.red[700],
              splashColor: Colors.orange[300],
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Text("  Eliminar Cita  "),
              onPressed:() async{
                Firestore.instance.collection('events').document(widget.event.id).delete();
                Navigator.pop(context);
              } 
            ),
          ],
        ),
      ),
    );
  }
}