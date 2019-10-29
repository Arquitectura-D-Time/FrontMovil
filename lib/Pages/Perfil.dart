import 'package:flutter/material.dart';
import 'package:flutter_app_prueba_uno/Common/TutoriasAppBar.dart';
import 'package:flutter_app_prueba_uno/Web/QueryMutation.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app_prueba_uno/Util/ScreenUtil.dart';
import 'package:flutter_app_prueba_uno/singletonInstance/UserSingleton.dart';

class PerfilUI extends StatelessWidget {
  QueryMutations queries = QueryMutations();

  @override
  Widget build(BuildContext context) {

    return Query(
        options: QueryOptions(
          document: queries.getComentarios(),
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
      );

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
              Image.network(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                height: getHeightWithoutSafeArea(context) * 0.10,
                width: getHeightWithoutSafeArea(context) * 0.10,
              ),
              Text(
                'Soy un hp buo',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: getHeightWithoutSafeArea(context) * 0.02,
          ),
          FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.blueAccent,
            onPressed: () {
              /*...*/
            },
            child: Text(
              "Tutorias Agendadas",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          SizedBox(
            height: getHeightWithoutSafeArea(context) * 0.02,
          ),
          Container(
              height: getFullScreenHeight(context) * 0.65,
              child: _buildList(result)),
        ],
      ),
    );
  }

  Widget _buildList(QueryResult result) {
    final _suggestions = result.data['getComentarios'];
    return ListView.builder(
      itemCount: _suggestions.length,
      itemBuilder: (context, i) {
        print(UserSingleton().id == _suggestions[i]['idcomentado'].toString());

        if (UserSingleton().id != _suggestions[i]['idcomentado'].toString()) {
          return _Cards(
              _suggestions[i]['idcomento'].toString(),
              _suggestions[i]['comentario'],
              _suggestions[i]['hora'],
              _suggestions[i]['fecha']);
        }else{
          return SizedBox(
            height: 0,
          );
        }
      },
    );
  }

  Widget _Cards(String idcomento, String cometario, String hora, String fecha) {
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
                  leading: Image.network(
                      'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/f9/f9bc24dcfc04459063b2cc486942a86754e675dc_full.jpg'),
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
}
