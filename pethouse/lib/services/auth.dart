import 'package:firebase_auth/firebase_auth.dart';
import 'package:pethouse/models/user.dart';

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

  //Anónimo
  Future singInAnom() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFormFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //Iniciar sesión con correo y contraseña

  //Redistrarse

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