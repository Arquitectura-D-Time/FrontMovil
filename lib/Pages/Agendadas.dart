import 'package:flutter/material.dart';
import 'package:flutter_app_prueba_uno/Common/TutoriasAppBar.dart';
import 'package:flutter_app_prueba_uno/Web/QueryMutation.dart';
import 'package:flutter_app_prueba_uno/singletonInstance/UserSingleton.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

class AgendadasUI extends StatelessWidget {

  QueryMutations queries = QueryMutations();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Query(
        options: QueryOptions(
          document: queries.agendadasByAlumno(IDalumno : int.parse(UserSingleton().id)),
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
    final _suggestions = result.data['agendadasByAlumno'];
    print('que taaaaaaaaaaaaaaaaaaal');
    print(_suggestions[0]['IDtutoria']);
    print(UserSingleton().id);
    return ListView.builder(
      itemBuilder: (context, i) {
        if (i < _suggestions.length) {
            return _Cards(context,
                _suggestions[i]['IDtutoria'],
                _suggestions[i]['IDalumno'],
                _suggestions[i]['NombreAlumno']
            );
          }
      },
    );
  }

  Widget _Cards(BuildContext context, int IDtutoria, int IDalumno, String NombreAlumno) {

    QueryMutations queries2 = QueryMutations();

    return Query(
        options: QueryOptions(
        document: queries2.horarioById(IDtutoria: IDtutoria),
      ),
      builder: (QueryResult result2, {VoidCallback refetch}) {
      if (result2.loading) {
        return Center(child: CircularProgressIndicator());
      }

      if (result2.data == null) {
      //return Center(child: Text('Countries not found.'));
        print(result2.errors);
      }
      print(jsonDecode(jsonEncode(result2.data)));

      var res = jsonDecode(jsonEncode(result2.data));
      print("holaaa");
      print(res['horarioById'][0]);
      print(jsonDecode(jsonEncode(res['horarioById'][0])));
      var res2 = jsonDecode(jsonEncode(res['horarioById'][0]));
      print(res2['NombreMateria']);


      return Center(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.class_),
                title: Text(res2['NombreMateria']),
                subtitle: Text('Fecha:\t\t\t\t\t' +
                    res2['Fecha'] +
                '\nHorario:\t\t ' +
                    res2['HoraInicio'] +
                ' - ' +
                    res2['HoraFinal'] +
                '\nCupos:\t\t\t\t ' +
                    res2['Cupos'].toString()
                ),
              ),
              ButtonTheme.bar(
                // make buttons use the appropriate styles for cards
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: const Text('Ver Perfil del Tutor'),
                      onPressed: () {
                        /* ... */
                      },
                  ),
                    FlatButton(
                      child: const Text('Modificar'),
                      onPressed: () {
                        /* ... */
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
