import 'package:flutter/material.dart';
import 'package:pethouse/shared/constants.dart';
import 'package:pethouse/models/user.dart';
import 'package:provider/provider.dart';
import 'package:pethouse/services/database.dart';

class LogAdmin extends StatefulWidget {

  final Function goAdmin;
  LogAdmin ({ this.goAdmin });

  @override
  _LogAdminState createState() => _LogAdminState();
}

class _LogAdminState extends State<LogAdmin> {

  final _formKey = GlobalKey<FormState>();
  String password = '';

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        UserData userData = snapshot.data;
        return Scaffold(
          backgroundColor: Colors.brown[50],
            appBar: AppBar(
              title: Text('Entrar como administrador'),
              backgroundColor: Colors.brown[400],
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.pageview),
                  label: Text('Regresar',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  onPressed: () async {
                    await DatabaseService (uid: user.uid).updateUserData(userData.name, userData.email, userData.password, !userData.admin);
                    //await widget.changeHome();
                  }, 
                ),
              ],
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
                            await widget.goAdmin();
                          }
                        } 
                      },
                    ),
                  ]
                ),
              ), 
            ),
        );
      }
    );
  }
}