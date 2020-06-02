class User {

  final String uid;

  User({ this.uid });
  
}

class UserData{

  final String uid;
  final String name;
  final String email;
  final String password;
  final bool client;

  UserData({ this.uid, this.name, this.email, this.password, this.client });

}

class UserName {

  String email;
  String password;
  String nickname;

  UserName({ this.email, this.password, this.nickname });

} 

