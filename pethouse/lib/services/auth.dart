//auth: Modulo que llama las funciones de Firebase para iniciar sesión, registrarse como cliente o administrador y cerrar sesión
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pethouse/models/user.dart';
import 'package:pethouse/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //crear un objeto usuario en firebaseUser
  User _userFormFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  //cambio de autenticación de usuario
  Stream<User> get user {
    return _auth.onAuthStateChanged
    .map(_userFormFirebaseUser);
  }

  //Iniciar sesión con correo y contraseña
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFormFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //Registrarse como administrador
   Future registerWithEmailAndPasswordAdmin(String name, String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      await DatabaseService(uid: user.uid).updateUserData(name, email, password, true);
      return _userFormFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //Registrarse como cliente
  Future registerWithNameEmailAndPasswordClient(String name, String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      await DatabaseService(uid: user.uid).updateUserData(name, email, password, false);
      return _userFormFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //cerrar sesión
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }

}