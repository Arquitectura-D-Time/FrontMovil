import 'package:flutter/material.dart';
import 'package:flutter_app_prueba_uno/Common/TutoriasAppBar.dart';
import 'package:flutter_app_prueba_uno/Pages/Login.dart';
import 'package:flutter_app_prueba_uno/Web/QueryMutation.dart';
import 'package:flutter_app_prueba_uno/singletonInstance/UserSingleton.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/foundation.dart';

class AgendadasUI extends StatelessWidget {
  //final _suggestions =['asd','asdsss','asds','asdd','asda','asd','asdsss','asds','asdd','asda'];

  QueryMutations queries = QueryMutations();


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
        itemCount: _suggestions.length,
        itemBuilder: (context, i) {
          if(_suggestions[i]['IDalumno'] != UserSingleton().id){
            return _Cards("Matematicas", _suggestions[i]['IDtutoria'], 2);
          }
          else{
            return SizedBox(
              height: 0,
            );
          }
      },
    );
  }

  Widget _Cards(String materia, int IDtutoria, int IDalumno) {



    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.class_),
              title: Text(materia),
              subtitle: Text(IDtutoria.toString()),
            ),
            ButtonTheme.bar(
              // make buttons use the appropriate styles for cards
              child: ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Text('Editar'),
                    onPressed: () {/* ... */},
                  ),
                  FlatButton(
                    child: const Text('Borrar'),
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
