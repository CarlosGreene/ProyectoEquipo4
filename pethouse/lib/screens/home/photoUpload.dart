import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pethouse/screens/home/Imagenes.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';



class PhotoUpload extends StatefulWidget {
  @override
  _PhotoUploadState createState() => _PhotoUploadState();
}
class _PhotoUploadState extends State<PhotoUpload> {
  File sampleImage; ///imagen

  String _myValue; ///descripción de la imagen
  String url; ///url de la imagen
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {///Pagina que muestran las imagenes subidas por el usuario
    //TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("UploadImage"),
        centerTitle: true,
      ),
      body: Center(
        child: sampleImage == null
            ? Text("Select and Image")
            : enableUpload(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: "Add Image",
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Future getImage() async {
    var tempImage =
    await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = tempImage;
    });
  }

///Contenido de la pagina Upload, cuando se selecciona una imagen se abre la ventana para ponerle nombre.
  Widget enableUpload() {
    return SingleChildScrollView(
      child: Container(
        child:Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
              Image.file(sampleImage,
              height: 300.0,
              width: 600.0,
              ),
              SizedBox(height: 15.0,),
              TextFormField(
              decoration: InputDecoration(
                labelText:"Name"
              ),
              validator: (value){
                return value.isEmpty ? "Se requiere Nombre" : null;
              },
              onSaved: (value){
                return _myValue = value;
              },
              ),
              SizedBox(
              height: 15.0,
              ),
              RaisedButton(
                elevation: 10.0,
                child: Text("Upload"),
                textColor: Colors.white,
                color: Colors.orangeAccent,
                onPressed: uploadStatusImage,
              )
          ],
        ),
      ),
    )
      ),
    );
  }

  void uploadStatusImage() async{
    if(validateAndSave()){
      ///Funcion que sube la imagen a firebase storage
      final StorageReference postIamgeRef =
      FirebaseStorage.instance.ref().child("Post Image");
      var timeKey = DateTime.now();
      final StorageUploadTask uploadTask =
      postIamgeRef.child(timeKey.toString()+"jpg").putFile(sampleImage);
      var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      url = imageUrl.toString();
      print("Image url" + url);

      ///Guardar el post a firebase database: database realtime
      saveToDatabase(url);

      // Regresar a Galeria
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context){
return Imagenes();
      }

      ));
    }
  }

  void saveToDatabase(String url){
    ///Guarda la imagen(imagen,nombre,date,time)
    var dbTimeKey = DateTime.now();
    var formatDate = DateFormat('MMM d, yyyy');
    var formatTime = DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);
    ///Se guarda los datos en firebase storage
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var data = {

      "image" : url,
      "description":_myValue,
      "date": date,
      "time":time
    };
    ref.child("Posts").push().set(data);
    }

  bool validateAndSave(){
    final form = formKey.currentState;
    if (form.validate()){
      form.save();
      return true;
    } else {
      return false;
    }
    }
}