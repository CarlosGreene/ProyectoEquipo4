import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:flutter/cupertino.dart';

class EventModel extends DatabaseItem{
  final String id;
  final String title;
  final String pNumber;
  final String mail;
  final DateTime eventDate;

  EventModel({this.id,this.title, this.pNumber, this.mail, this.eventDate}):super(id);

  factory EventModel.fromMap(Map data) {
    return EventModel(
      title: data['name'],
      pNumber: data['pNumber'],
      mail: data['mail'],
      eventDate: data['event_Date']
    );
  }

  factory EventModel.fromDS(String id, Map<String,dynamic> data) {
    return EventModel(
      id: id,
      title: data['name'],
      pNumber: data['pNumber'],
      mail: data['mail'],
      eventDate: data['event_date'].toDate(),
    );
  }

  Map<String,dynamic> toMap() {
    return {
      "name":title,
      "pNumber": pNumber,
      "mail":mail,
      "event_date":eventDate,
      "id":id,
    };
  }
}