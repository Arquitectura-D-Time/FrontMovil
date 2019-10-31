import 'package:flutter/material.dart';
import 'package:flutter_app_prueba_uno/LogIn_Home.dart';
import 'package:flutter_app_prueba_uno/Pages/Agendadas.dart';
import 'package:flutter_app_prueba_uno/Pages/Login.dart';
import 'package:flutter_app_prueba_uno/Pages/Perfil.dart';
import 'package:flutter_app_prueba_uno/Pages/VerTutorias.dart';
import 'package:flutter_app_prueba_uno/Web/QueryMutation.dart';
import 'package:flutter_app_prueba_uno/Common/TutoriasAppBar.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/foundation.dart';

import 'Web/GraphQLConfiguration.dart';


GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
AgendadasUI agendadasUI = AgendadasUI();

void main() => runApp(
  GraphQLProvider(
    client: graphQLConfiguration.client,
    child: CacheProvider(child: MyApp()),
  ),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LogIn(),
    );
  }
}