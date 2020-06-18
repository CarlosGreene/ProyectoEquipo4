//eventDB: genera una instancia de Base de Datos que permite la escritura y validación del modelo de evento según los datos ingresados por 
//el usuario
import 'package:firebase_helpers/firebase_helpers.dart';
import '../models/event.dart';

DatabaseService<EventModel> eventDBS = DatabaseService<EventModel>(
  "events",fromDS: (id,data) => EventModel.fromDS(
    id, data), toMap:(event) => event.toMap());