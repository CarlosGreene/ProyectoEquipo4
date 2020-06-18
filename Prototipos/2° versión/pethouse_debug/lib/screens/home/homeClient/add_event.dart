import 'package:pethouse/models/event.dart';
import 'package:flutter/material.dart';
import 'package:pethouse/red/event_firestore_service.dart';

class AddEventPage extends StatefulWidget {
  final EventModel note;

  const AddEventPage({Key key, this.note}) : super(key: key);

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _title;
  TextEditingController _pNumber;
  TextEditingController _mail;
  DateTime _eventDate;
  TimeOfDay time;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool processing;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.note != null ? widget.note.title : "");
    _pNumber = TextEditingController(text:  widget.note != null ? widget.note.pNumber : "");
    _mail = TextEditingController(text:  widget.note != null ? widget.note.mail : "");
    _eventDate = DateTime.now();
    time = TimeOfDay.now();
    processing = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note != null ? "Edit Note" : "Agendar Cita"),
      ),
      key: _key,
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _title,
                  validator: (value) =>
                      (value.isEmpty) ? "Ingrese su nombre completo" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "nombre completo",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _pNumber,
                  validator: (value) =>
                      (value.isEmpty) ? "Ingrese su número telefonico" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "número telefonico",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _mail,
                  validator: (value) =>
                      (value.isEmpty) ? "Ingrese su correo electrónico" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "correo electrónico",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              const SizedBox(height: 10.0),
              ListTile(
                title: Text("Fecha (AAAA-MM-DD)"),
                subtitle: Text("${_eventDate.year} - ${_eventDate.month} - ${_eventDate.day}"),
                onTap: ()async{
                  DateTime picked = await showDatePicker(context: context, initialDate: _eventDate, firstDate: DateTime(_eventDate.year-5), lastDate: DateTime(_eventDate.year+5));
                  if(picked != null) {
                    setState(() {
                      _eventDate = picked;
                    });
                    _pickTime();
                  }
                },
              ),
              SizedBox(height: 10.0),
              processing
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Theme.of(context).primaryColor,
                        child: MaterialButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                processing = true;
                              });
                              if(widget.note != null) {
                                await eventDBS.updateData(widget.note.id,{
                                  'name': _title.text,
                                  'pNumber': _pNumber.text,
                                  'mail': _mail.text,
                                  'date_time': widget.note.eventDate,
                                }
                                );
                              }else{
                                await eventDBS.createItem(EventModel(
                                  title: _title.text,
                                  pNumber: _pNumber.text,
                                  mail: _mail.text,
                                  eventDate: DateTime(_eventDate.year, _eventDate.month, _eventDate.day, time.hour, time.minute)
                                ));
                              }
                              Navigator.pop(context);
                              setState(() {
                                processing = false;
                              });
                            }
                          },
                          child: Text(
                            "Guardar",
                            style: style.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
  _pickTime() async{
    TimeOfDay t = await showTimePicker(
      context: context, 
      initialTime: time
      );

      if(t != null)
        setState(() {
          time = t;
        });
    }

  @override
  void dispose() {
    _title.dispose();
    _pNumber.dispose();
    _mail.dispose();
    super.dispose();
  }
}