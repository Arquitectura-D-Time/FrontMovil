class QueryMutations {
  //.................. Schedule ..............................................//
  String getAllAgendadas() {
    return '''
            query {
              allAgendadas {
                IDtutoria
                IDalumno
                NombreAlumno
              }
            }
            ''';
  }

  String agendadasByTutoria(int IDtutoria) {
    return '''
            query {
              agendadasByTutoria(IDtutoria: $IDtutoria){
                IDtutoria
                IDalumno
                NombreAlumno
              }
            }
            ''';
  }

  String agendadasByAlumno({int IDalumno}) {
    return '''
            query {
              agendadasByAlumno(IDalumno: $IDalumno){
                IDtutoria
                IDalumno
                NombreAlumno
              }
            }
            ''';
  }

  String createAgendadas({int IDtutoria, int IDalumno, String NombreAlumno}) {
    return '''
          mutation {
            createAgendadas(agendadas: {
              IDtutoria: $IDtutoria
              IDalumno: $IDalumno
              NombreAlumno: "$NombreAlumno"
            }) {
              IDtutoria
              IDalumno
              NombreAlumno
            }
          }
          ''';
  }

  String updateAgendadas(int IDtutoria, int IDalumno, String NombreAlumno) {
    return '''
      mutation {
        updateAgendadas(IDtutoria: $IDtutoria IDalumno: $IDalumno agendadas: {
          NombreAlumno: "$NombreAlumno"
        }) {
          IDtutoria
          IDalumno
          NombreAlumno
        }
      }
      ''';
  }

  String deleteAgendadas(int IDtutoria, int IDalumno) {
    return '''
      mutation {
        deleteAgendadas(IDtutoria: $IDtutoria, IDalumno: $IDalumno)
      }
    ''';
  }

  String createHorario(int IDtutoria, int IDtutor, String NombreMateria,
      String Fecha, String HoraInicio, String HoraFinal, int Cupos) {
    return '''
      mutation {
        createHorario(horario: {
          IDtutoria: $IDtutoria 
          IDtutor: $IDtutor
          NombreMateria: "$NombreMateria"
          Fecha: "$Fecha"
          HoraInicio: "$HoraInicio"
          HoraFinal: "$HoraFinal"
          Cupos: "$Cupos"
        }) {
          IDtutoria
          IDtutor
          NombreMateria
          Fecha
          HoraInicio
          HoraFinal
          Cupos
        }
      }
      ''';
  }

  String allHorarios() {
    return '''
      query {
        allHorarios{
        IDtutoria
        IDtutor
        NombreMateria
        Fecha
        HoraInicio
        HoraFinal
        Cupos
      }
    }
    ''';
  }

  String horarioById({int IDtutoria}) {
    return '''
      query {
        horarioById(IDtutoria: $IDtutoria) {
          IDtutoria
          IDtutor
          NombreMateria
          Fecha
          HoraInicio
          HoraFinal
          Cupos
        }
      }
    ''';
  }

  String horarioByTutor({int IDtutor}) {
    return '''
      query {
        horarioByTutor(IDtutoria: $IDtutor) {
          IDtutoria
          IDtutor
          NombreMateria
          Fecha
          HoraInicio
          HoraFinal
          Cupos
        }
      }
    ''';
  }

  String updateHorario(int IDtutoria, int IDtutor, String NombreMateria,
      String Fecha, String HoraInicio, String HoraFinal, int Cupos) {
    return '''
      mutation {
        updateHorario(IDtutoria: $IDtutoria IDtutor: $IDtutor horario: {
          NombreMateria: "$NombreMateria"
          Fecha: "$Fecha"
          HoraInicio: "$HoraInicio"
          HoraFinal: "$HoraFinal"
          Cupos: "$Cupos"
        }) {
          IDtutoria
          IDtutor
          NombreMateria
          Fecha
          HoraInicio
          HoraFinal
          Cupos
        }
      }
    ''';
  }

  String deleteHorario(int IDtutoria, int IDtutor) {
    return '''
      mutation {
        deleteHorario(IDtutoria: $IDtutoria IDtutor:$IDtutor)
      }
    ''';
  }

  //.................. Sing ..................................................//
  String createUser(
      {String email,
      String name,
      String nickname,
      String password,
      String passwordC}) {
    String query = '''
                    mutation{
                      createUser(user: {
                        email: "$email"
                        name: "$name"
                        nickname: "$nickname"
                        password: "$password"
                        password_confirmation: "$password"
                      }) {
                      id
                      email
                      name
                      nickname
                      image
                      token
                      type
                      client
                      uid
                      }
                    }
                    ''';
    return query;
  }

  String createSession({email, password}) {
    String query = '''
                    mutation{
                      createSession(session: {
                      email: "$email"
                      password: "$password"
                      }) {
                      id
                      email
                      name
                      nickname
                      token
                      type
                      client
                        uid
                      }
                    }
                    ''';
    return query;
  }

  String userById({int idUser}){
    String query = '''
                    query{
                      userById(idUser: $idUser){
                        name
                        nickname
                        email
                      }
                    }
                  ''';
    return query;
  }


//......................Comentarios..........................................//
String getComentarios() {
  String query = '''
      query {
        getComentarios{
            idcomento
            idcomentado
            comentario
            fecha
            hora
        }
      }
                    ''';
  return query;
}

String getComentarioById(int idcomento, int idcomentado) {
  String query = '''
    query {
      comentarioById(idcomento: $idcomento, idcomentado: $idcomentado) {
          idcomento
          idcomentado
          comentario
          fecha
          hora
      }
    }
                    ''';
  return query;
}

String createComentario(int idcomento, int idcomentado, String comentario,
    String fecha, String hora) {
  String query = '''
    mutation {
        createComentario(comentario: {
            idcomento: $idcomento
            idcomentado: $idcomentado
            comentario: "$comentario"
            fecha: "$fecha"
            hora: "$hora"
        }){
            idcomento
            idcomentado
            comentario
            fecha
            hora
        }
    }
                    ''';
  return query;
}

String updateComentario(int idcomento, int idcomentado, String comentario,
    String fecha, String hora) {
  String query = '''
    mutation {
        updateComentario(idcomento:$idcomento, idcomentado:$idcomentado, comentario: {
            comentario: "$comentario"
            fecha: "$fecha"
            hora: "$hora"
        }) {
            comentario
    				fecha
    				hora
        }
    }
                    ''';
  return query;
}

String deleteComentario(int idcomento, int idcomentado) {
  String query = '''
    mutation {
      deleteComentario(idcomento:$idcomento, idcomentado:$idcomentado)
    }
                    ''';
  return query;
}
}



//...................Turorias.............................................//
