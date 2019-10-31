import 'package:flutter/material.dart';
import 'package:flutter_app_prueba_uno/Common/TutoriasAppBar.dart';
import 'package:flutter_app_prueba_uno/Pages/Agendadas.dart';
import 'package:flutter_app_prueba_uno/Pages/Perfil.dart';
import 'package:flutter_app_prueba_uno/Pages/VerTutorias.dart';
import 'package:flutter_app_prueba_uno/Web/QueryMutation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app_prueba_uno/singletonInstance/UserSingleton.dart';

class CargaAgendarUI extends StatelessWidget {
  QueryMutations queries = QueryMutations();
  var su = UserSingleton();

  @override
  Widget build(BuildContext context) {
    print(su.name.toString());
    return Scaffold(
      appBar: TutoriasAppBar().build(context),
      body: Query(
        options: QueryOptions(
            document: queries.createAgendadas(
              IDtutoria: su.idTutoriaAgendada,
              IDalumno: int.parse(su.id),
              NombreAlumno: su.name,
            )),
        builder: (QueryResult result, {VoidCallback refetch}) {
          if (result.loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (result.data == null) {
            print(result.errors);
          }
          return AgendadasUI();
        },
      ),
    );
  }
}
