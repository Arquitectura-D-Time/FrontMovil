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

class CargaLoginUI extends StatelessWidget {
  QueryMutations queries = QueryMutations();
  var su = UserSingleton();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TutoriasAppBar().build(context),
      body: Query(
        options: QueryOptions(
            document: queries.createSession(
          email: su.email,
          password: su.password,
        )),
        builder: (QueryResult result, {VoidCallback refetch}) {
          if (result.loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (result.data == null) {
            //return Center(child: Text('Countries not found.'));
            print(result.errors);
            //Navigator.pop(context);
          }
          var jsonA = jsonEncode(result.data);
          print(jsonA);
          print(jsonDecode(jsonA));
          print(jsonDecode(jsonA)['createSession']['id']);

          su.id = (jsonDecode(jsonA)['createSession']['id']).toString();
          su.email = (jsonDecode(jsonA)['createSession']['email']).toString();
          su.name = (jsonDecode(jsonA)['createSession']['name']).toString();
          su.nickname = (jsonDecode(jsonA)['createSession']['nickname']).toString();
          su.token = (jsonDecode(jsonA)['createSession']['token']).toString();
          su.type = (jsonDecode(jsonA)['createSession']['type']).toString();
          su.client = (jsonDecode(jsonA)['createSession']['client']).toString();
          su.uid = (jsonDecode(jsonA)['createSession']['uid']).toString();

          print('id: ' + su.id);
          return VerTutoriasUI();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PerfilUI()));
          //return _buildList(result);
        },
      ),
    );
  }
}
