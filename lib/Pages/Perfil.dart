import 'package:flutter/material.dart';
import 'package:flutter_app_prueba_uno/Common/TutoriasAppBar.dart';
import 'package:flutter_app_prueba_uno/Pages/Agendadas.dart';
import 'package:flutter_app_prueba_uno/Pages/Comentarios.dart';
import 'package:flutter_app_prueba_uno/Web/QueryMutation.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app_prueba_uno/Util/ScreenUtil.dart';
import 'package:flutter_app_prueba_uno/singletonInstance/UserSingleton.dart';

class PerfilUI extends StatelessWidget {
  QueryMutations queries = QueryMutations();
  UserSingleton us = UserSingleton();
  String idPerfil;

  @override
  Widget build(BuildContext context) {
    idPerfil = us.idPerfil.toString();
    return Scaffold(
        appBar: TutoriasAppBar().build(context),
        body: Query(
      options: QueryOptions(
        document: queries.getAllComentariosById(int.parse(idPerfil)),
      ),
      builder: (QueryResult result, {VoidCallback refetch}) {
        if (result.loading) {
          return Center(child: CircularProgressIndicator());
        }

        if (result.data == null) {
          //return Center(child: Text('Countries not found.'));
          print(result.errors);
        }
        return _mainContainer(context, result);
        //return _buildList(result);
      },
    ));
  }

  Widget _mainContainer(BuildContext context, QueryResult result) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: getHeightWithoutSafeArea(context) * 0.02,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Query(
                options: QueryOptions(
                  document: queries.getImageById(int.parse(idPerfil)),
                ),
                builder: (QueryResult result, {VoidCallback refetch}) {
                  if (result.loading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (result.data == null) {
                    //return Center(child: Text('Countries not found.'));
                    print(result.errors);
                  }
                  return Image.network(
                    result.data["imageById"]["urlimg"],
                    height: getHeightWithoutSafeArea(context) * 0.10,
                    width: getHeightWithoutSafeArea(context) * 0.10,
                  );
                  //return _buildList(result);
                },
              ),
              Query(
                options: QueryOptions(
                  document: queries.userById(idUser: int.parse(idPerfil)),
                ),
                builder: (QueryResult result, {VoidCallback refetch}) {
                  if (result.loading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (result.data == null) {
                    //return Center(child: Text('Countries not found.'));
                    print(result.errors);
                  }
                  return Text(
                    result.data["userById"]["name"],
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  );
                  //return _buildList(result);
                },
              )
            ],
          ),
          SizedBox(
            height: getHeightWithoutSafeArea(context) * 0.02,
          ),
          SizedBox(
            height: getHeightWithoutSafeArea(context) * 0.02,
          ),
          Container(
              height: getFullScreenHeight(context) * 0.65,
              child: _buildList(context, result)),
          FloatingActionButton(
            onPressed: () {
              _botonMas(context);
            },
            tooltip: 'Agregar Comentario',
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context, QueryResult result) {
    final _suggestions = result.data['comentariosAllById'];
    return ListView.builder(
      itemCount: _suggestions.length,
      itemBuilder: (context, i) {
        print(UserSingleton().id == _suggestions[i]['idcomentado'].toString());

        return _Cards(
            context,
            _suggestions[i]['idcomento'].toString(),
            _suggestions[i]['comentario'],
            _suggestions[i]['hora'],
            _suggestions[i]['fecha']);
      },
    );
  }

  Widget _Cards(BuildContext context, String idcomento, String cometario,
      String hora, String fecha) {
    return Query(
      options: QueryOptions(
        document: ''' 
          query{
            userById(idUser: $idcomento){
              name
              nickname
              email
            }
         }
        ''',
      ),
      builder: (QueryResult result, {VoidCallback refetch}) {
        if (result.loading) {
          return Center(child: CircularProgressIndicator());
        }

        if (result.data == null) {
          //return Center(child: Text('Countries not found.'));
          print(result.errors);
        }
        return Center(
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Query(
                    options: QueryOptions(
                      document: queries.getImageById(int.parse(idcomento)),
                    ),
                    builder: (QueryResult result, {VoidCallback refetch}) {
                      if (result.loading) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (result.data == null) {
                        //return Center(child: Text('Countries not found.'));
                        print(result.errors);
                      }
                      return Image.network(result.data["imageById"]["urlimg"]);
                      //return _buildList(result);
                    },
                  ),
                  /*Image.network(
                      'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/f9/f9bc24dcfc04459063b2cc486942a86754e675dc_full.jpg'),*/
                  title: Text(result.data['userById']['name']),
                  subtitle: Text(cometario),
                ),
                ButtonTheme.bar(
                  // make buttons use the appropriate styles for cards
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: Text(hora),
                        onPressed: () {
                          /* ... */
                        },
                      ),
                      FlatButton(
                        child: Text(fecha),
                        onPressed: () {
                          /* ... */
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
        //return _buildList(result);
      },
    );
  }

  _botonMas(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ComentariosUI()));
  }
}
