class Agendadas {
  String getAllAgendadas(){
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

  String getByIDtutoriaAgendadas(int IDtutoria){
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

  String getByIDalumnoAgendadas(int IDalumno){
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

  String createAgendadas(int IDtutoria, int IDalumno, String NombreAlumno){
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

  String updateAgendadas(){
    return '''
      mutation {
        updateAgendadas(IDtutoria: 100 IDalumno: 600 agendadas: {
          NombreAlumno: "Juan"
        }) {
          IDtutoria
          IDalumno
          NombreAlumno
        }
      }
      ''';
  }

  String deleteAgendadas(){
    return '''
      mutation {
        deleteAgendadas(IDtutoria:100, IDalumno:600)
      }
    ''';
  }

}


