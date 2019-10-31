import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_prueba_uno/Common/TutoriasAppBar.dart';
import 'package:flutter_app_prueba_uno/Pages/CrearTutoria.dart';
import 'package:flutter_app_prueba_uno/Pages/Perfil.dart';
import 'package:flutter_app_prueba_uno/Pages/VerTutorias.dart';
import 'package:flutter_app_prueba_uno/Web/QueryMutation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app_prueba_uno/Cargas/CargaAgendar.dart';
import 'package:flutter_app_prueba_uno/singletonInstance/UserSingleton.dart';
import 'package:flutter_app_prueba_uno/Util/ScreenUtil.dart';

class MisTutoriasUI extends StatelessWidget {
  QueryMutations queries = QueryMutations();
  var su = UserSingleton();

  _cargaAgendar(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CargaAgendarUI()));
  }

  _verPerfil(BuildContext context) {
    return PerfilUI();
  }

  _crearTutoria(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CrearTutoriaUI()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Query(
        options: QueryOptions(
          document:
              queries.horarioByTutor(IDtutor: int.parse(UserSingleton().id)),
        ),
        builder: (QueryResult result, {VoidCallback refetch}) {
          if (result.loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (result.data == null) {
            //return Center(child: Text('Countries not found.'));
            print(result.errors);
          }
          return _buildList(result, context);
        },
      ),
    );
  }

  Widget _buildList(QueryResult result, BuildContext context) {
    var buttonCrearTutoria = Container(
      height: getHeightWithoutSafeArea(context) * 0.05,
      width: getFullScreenWidth(context) * 0.5,
      child: FlatButton(
        color: Colors.lightGreen,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Text("Crear Tutoria",
            style: TextStyle(
                letterSpacing: 3.0, color: Colors.white, fontSize: 18)),
        onPressed: () {
          _crearTutoria(context);
        },
      ),
    );

    final _suggestions = result.data['horarioByTutor'];
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          buttonCrearTutoria,
          Container(
            width: getFullScreenWidth(context),
            height: getHeightWithoutSafeArea(context)*0.75,
            child: ListView.builder(
              itemBuilder: (context, i) {
                if (i < _suggestions.length) {
                  return _Cards(
                      context,
                      _suggestions[i]['IDtutoria'],
                      _suggestions[i]['IDtutor'],
                      _suggestions[i]['NombreMateria'],
                      _suggestions[i]['Fecha'],
                      _suggestions[i]['HoraInicio'],
                      _suggestions[i]['HoraFinal'],
                      _suggestions[i]['Cupos']);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _Cards(BuildContext context, int IDtutoria, int IDtutor,
      String materia, String fecha, String horaIni, String horaFin, int cupos) {
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
                      cupos.toString()),
                ),
                ButtonTheme.bar(
                  // make buttons use the appropriate styles for cards
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text('Modificar'),
                        onPressed: () {
                          su.idTutoriaAgendada = IDtutoria;
                          _cargaAgendar(context);
                        },
                      ),
                      FlatButton(
                        child: const Text('Eliminar'),
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
