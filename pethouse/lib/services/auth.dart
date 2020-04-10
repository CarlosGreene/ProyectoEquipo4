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

  //Redistrarse
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      //await DatabaseService(uid: user.uid).updateUserData('0', 'new crew member', 100);
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