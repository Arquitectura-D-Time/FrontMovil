import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// HttpLink - A system of modular components for GraphQL networking.
    final HttpLink httpLink =
    HttpLink(
        uri: 'http://146.148.107.218:5000/graphql?'
    );

    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: httpLink as Link,
        cache: OptimisticCache(
          dataIdFromObject: typenameDataIdFromObject,
        ),
      ),
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GraphQLProvider(
        child: CountryListView(),
        client: client,
      ),
    );
  }
}


class CountryListView extends StatelessWidget {
  final String query = '''
                    query {
                      allAgendadas {
                        NombreAlumno
                      }
                    }
                    ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Countries'),
      ),
      body: Query(
        options: QueryOptions(
            document: query,
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
    final countryList = result.data['allAgendadas'];

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
