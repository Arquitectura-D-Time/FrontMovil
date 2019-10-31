import 'package:flutter/material.dart';
import 'package:flutter_app_prueba_uno/Common/TutoriasAppBar.dart';
import 'package:flutter_app_prueba_uno/Pages/Perfil.dart';
import 'package:flutter_app_prueba_uno/Pages/VerTutorias.dart';
import 'package:flutter_app_prueba_uno/Web/QueryMutation.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app_prueba_uno/Util/ScreenUtil.dart';
import 'package:flutter_app_prueba_uno/singletonInstance/UserSingleton.dart';

class CargaUI extends StatelessWidget {
  QueryMutations queries = QueryMutations();
  var su = UserSingleton();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TutoriasAppBar().build(context),
      body: Query(
        options: QueryOptions(
          document:queries.createUser(
              email: su.email,
              name: su.name,
              nickname: su.nickname,
              password: su.password,
              passwordC: su.password
              )
        ),
        builder: (QueryResult result, {VoidCallback refetch}) {
          if (result.loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (result.data == null) {
            //return Center(child: Text('Countries not found.'));
            print(result.errors);
            Navigator.pop(context);
          }
          Navigator.push(
              context, MaterialPageRoute(builder: (context) =>  VerTutoriasUI()));
          //return _buildList(result);
        },
      ),
    );
  }
}