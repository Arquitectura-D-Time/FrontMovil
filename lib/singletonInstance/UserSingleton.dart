class UserSingleton {
  static final UserSingleton _instance = UserSingleton._internal();

  factory UserSingleton() => _instance;
  UserSingleton._internal() {
  // init things inside this
  }

  String id;
  String email;
  String name;
  String nickname;
  String image;
  String token;
  String type;
  String client;
  String uid;
  String password;

  int idTutoriaAgendada;
  int idPerfil;

}