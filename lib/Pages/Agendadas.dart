import 'package:flutter/material.dart';
import 'package:flutter_app_prueba_uno/Common/TutoriasAppBar.dart';
import 'package:flutter_app_prueba_uno/Web/QueryMutation.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/foundation.dart';

class AgendadasUI extends StatelessWidget {
  //final _suggestions =['asd','asdsss','asds','asdd','asda','asd','asdsss','asds','asdd','asda'];

  AgendadasQuery queries = AgendadasQuery();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: TutoriasAppBar().build(context),
      body: Query(
        options: QueryOptions(
          document: queries.getAllAgendadas(),
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
    final _suggestions = result.data['allAgendadas'];
    return ListView.builder(
      itemBuilder: (context, i) {
        if (i < _suggestions.length) {
          return _Cards(_suggestions[i]['NombreAlumno']);
        }
      },
    );
  }

  Widget _Cards(String cadenita) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.album),
              title: Text(cadenita),
              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
            ),
            ButtonTheme.bar(
              // make buttons use the appropriate styles for cards
              child: ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Text('BUY TICKETS'),
                    onPressed: () {/* ... */},
                  ),
                  FlatButton(
                    child: const Text('LISTEN'),
                    onPressed: () {/* ... */},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
