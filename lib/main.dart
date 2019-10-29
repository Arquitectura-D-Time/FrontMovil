import 'package:flutter/material.dart';
import 'package:flutter_app_prueba_uno/Pages/Agendadas.dart';
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
      home: agendadasUI,
    );
  }
}

/*
class CountryListView extends StatelessWidget {

  AgendadasQuery agen = AgendadasQuery();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:TutoriasAppBar().build(context),
      body: Query(
        options: QueryOptions(
          document: agen.getAllAgendadas(),
        ),
        builder: (QueryResult result, {VoidCallback refetch}) {
          print(result.data);
          if (result.loading) {
            return Center(child: CircularProgressIndicator());
          }
          print('xsdfs');
          print(result.data);
          print(result.errors);
          print('asdasd');
          if (result.data == null) {
            //return Center(child: Text('Countries not found.'));
            print(result.errors);
          }
          return _countriesView(result);
        },
      ),
    );
  }

  ListView _countriesView(QueryResult result) {
    final countryList = result.data['updateAgendadas'];

    debugPrint(countryList[0]['NombreAlumno']);

    return ListView.separated(
      itemCount: countryList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(countryList[index]['NombreAlumno']),
          onTap: () {
            final snackBar = SnackBar(
                content:
                Text('Selected Country: ${countryList[index]['NombreAlumno']}'));
            Scaffold.of(context).showSnackBar(snackBar);
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
*/