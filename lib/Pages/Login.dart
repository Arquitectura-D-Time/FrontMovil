import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_prueba_uno/Common/TutoriasAppBar.dart';
import 'package:flutter_app_prueba_uno/Web/QueryMutation.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/foundation.dart';

class LoginUI extends StatelessWidget {
  QueryMutations queries = QueryMutations();

  String hola = "ercruzr@unal.edu.co";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: TutoriasAppBar().build(context),
      body: Query(
        options: QueryOptions(
          document:'''
          mutation{
        createSession(session: {
        email: "ercruzr@unal.edu.co"
        password: "123456"
        }) {
        id
        email
        name
        nickname
        token
        type
        client
        uid
        }
        }'''

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
    final _suggestions = result.data;

    return ListView.builder(
      itemBuilder: (context, i) {
        if (i < _suggestions.length) {
          return _Cards(_suggestions[i]);
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