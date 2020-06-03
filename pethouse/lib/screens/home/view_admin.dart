import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:pethouse/models/event.dart';

class EventDetailsAdmin extends StatelessWidget {
  final EventModel event;
  
  const EventDetailsAdmin({Key key, this.event}) : super(key: key);

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
            Text(event.title, style: Theme.of(context).textTheme.display1,),
            SizedBox(height: 20.0),
            Text(event.pNumber, style: TextStyle(fontSize: 20)),
            SizedBox(height: 10.0),
            Text(event.mail, style: TextStyle(fontSize: 20)),
            SizedBox(height: 10.0),
            Text(formatDate(event.eventDate,[dd,'/',mm,'/',yyyy,'    ',hh,':',nn,'  ',am]), style: TextStyle(fontSize: 20)),
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
              onPressed:(){

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
              onPressed:(){
              } 
            ),
          ],
        ),
      ),
    );
  }
}
