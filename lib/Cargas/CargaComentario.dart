import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_prueba_uno/Common/TutoriasAppBar.dart';
import 'package:flutter_app_prueba_uno/Pages/Agendadas.dart';
import 'package:flutter_app_prueba_uno/Pages/Perfil.dart';
import 'package:flutter_app_prueba_uno/Pages/VerTutorias.dart';
import 'package:flutter_app_prueba_uno/Web/QueryMutation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app_prueba_uno/singletonInstance/UserSingleton.dart';
import 'dart:convert';

class CargaComentarioUI extends StatelessWidget {
  QueryMutations queries = QueryMutations();
  var su = UserSingleton();
  var comentariotxt;
  var idPerfil;
  @override
  Widget build(BuildContext context) {
    comentariotxt = su.comentariotxt;
    idPerfil = su.idPerfil;
    print(queries.createComentario(
        idcomento: int.parse(UserSingleton().id),
        idcomentado: int.parse(su.idPerfil),
        comentario: comentariotxt,
        fecha: DateTime.now().day.toString() +
            "-" +
            DateTime.now().month.toString() +
            "-" +
            DateTime.now().year.toString(),
        hora: DateTime.now().hour.toString() +
            ":" +
            DateTime.now().minute.toString()),
    );
    return Scaffold(
      appBar: TutoriasAppBar().build(context),
      body: Query(
        options: QueryOptions(
          document: queries.createComentario(
              idcomento: int.parse(UserSingleton().id),
              idcomentado: int.parse(su.idPerfil),
              comentario: comentariotxt,
              fecha: DateTime.now().day.toString() +
                  "-" +
                  DateTime.now().month.toString() +
                  "-" +
                  DateTime.now().year.toString(),
              hora: DateTime.now().hour.toString() +
                  ":" +
                  DateTime.now().minute.toString()),
        ),
        builder: (QueryResult result, {VoidCallback refetch}) {
          if (result.loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (result.data == null) {
            print('perra vida');
            Navigator.pop(context);
            //return Center(child: Text('Countries not found.'));
            print(result.errors);
          }
          Navigator.pop(context);
          //return _buildList(result);
        },
      )
    );
  }
}
