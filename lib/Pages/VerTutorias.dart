import 'package:flutter/material.dart';
import 'package:flutter_app_prueba_uno/Common/TutoriasAppBar.dart';
import 'package:flutter_app_prueba_uno/Pages/Perfil.dart';
import 'package:flutter_app_prueba_uno/Web/QueryMutation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app_prueba_uno/Cargas/CargaAgendar.dart';
import 'package:flutter_app_prueba_uno/singletonInstance/UserSingleton.dart';

class VerTutoriasUI extends StatelessWidget {
  QueryMutations queries = QueryMutations();
  var su = UserSingleton();

  _cargaAgendar(BuildContext context) {
    Navigator.push(
      context, MaterialPageRoute(builder: (context) =>  CargaAgendarUI()));
  }

  _verPerfil(BuildContext context) {
    return PerfilUI();
  }

  @override
  Widget build(BuildContext context) {

    var app = null;
    if (su.appBar == true){
      app = TutoriasAppBar().build(context);
      su.appBar = null;
    }

    return Scaffold(
      appBar: app,
      body: Query(
        options: QueryOptions(
          document: queries.allHorarios(),
        ),
        builder: (QueryResult result, {VoidCallback refetch}) {
          if (result.loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (result.data == null) {
            //return Center(child: Text('Countries not found.'));
            print(result.errors);
          }
          return _buildList(result);
        },
      ),
    );
  }

  Widget _buildList(QueryResult result) {
    final _suggestions = result.data['allHorarios'];
    return ListView.builder(
      itemBuilder: (context, i) {
        if (i < _suggestions.length) {
          return _Cards(context,
              _suggestions[i]['IDtutoria'],
              _suggestions[i]['IDtutor'],
              _suggestions[i]['NombreMateria'],
              _suggestions[i]['Fecha'],
              _suggestions[i]['HoraInicio'],
              _suggestions[i]['HoraFinal'],
              _suggestions[i]['Cupos']);
        }
      },
    );
  }

  Widget _Cards(BuildContext context, int IDtutoria, int IDtutor, String materia, String fecha,
      String horaIni, String horaFin, int cupos) {

    QueryMutations queries2 = QueryMutations();

    return Query(
        options: QueryOptions(
        document: queries2.userById(idUser: IDtutor),
      ),
      builder: (QueryResult result2, {VoidCallback refetch}) {
      if (result2.loading) {
      return Center(child: CircularProgressIndicator());
      }

      if (result2.data == null) {
      //return Center(child: Text('Countries not found.'));
      print(result2.errors);
      }
       return Center(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.class_),
                title: Text(materia),
                subtitle: Text('Fecha:\t\t\t\t\t' +
                    fecha +
                    '\nHorario:\t\t ' +
                    horaIni +
                    ' - ' +
                    horaFin +
                    '\nCupos:\t\t\t\t ' +
                    cupos.toString() +
                    '\nTutor: \t\t\t\t\t' +
                    result2.data['userById']['name'] +
                    '\nCorreo:\t\t\t\t' +
                    result2.data['userById']['email']
                ),
              ),
              ButtonTheme.bar(
                // make buttons use the appropriate styles for cards
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: const Text('Agendar'),
                      onPressed: () {
                        su.idTutoriaAgendada = IDtutoria;
                        _cargaAgendar(context);
                      },
                    ),
                    FlatButton(
                      child: const Text('Ver Perfil del Tutor'),
                      onPressed: () {
                        _verPerfil(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
       );
        //return _buildList(result);
      },
    );
  }
}