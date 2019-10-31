import 'package:flutter/material.dart';
import 'package:flutter_app_prueba_uno/Cargas/CargaComentario.dart';
import 'package:flutter_app_prueba_uno/Common/TutoriasAppBar.dart';
import 'package:flutter_app_prueba_uno/Pages/Agendadas.dart';
import 'package:flutter_app_prueba_uno/Web/QueryMutation.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app_prueba_uno/Util/ScreenUtil.dart';
import 'package:flutter_app_prueba_uno/singletonInstance/UserSingleton.dart';

class ComentariosUI extends StatelessWidget {
  var idPerfil = "3";
  var create = true;
  var textoInicial = "";
  var comentariotxt = "";
  QueryMutations queries = QueryMutations();
  UserSingleton us = UserSingleton();

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: queries.getComentarioById(
            idcomento: int.parse(UserSingleton().id),
            idcomentado: int.parse(idPerfil)),
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
    return Scaffold(
        body: Column(
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
        Query(
          options: QueryOptions(
            document: queries.getComentarioById(
                idcomento: int.parse(us.id), idcomentado: int.parse(idPerfil)),
          ),
          builder: (QueryResult result, {VoidCallback refetch}) {
            if (result.loading) {
              return Center(child: CircularProgressIndicator());
            }

            if (result.data == null) {
              //return Center(child: Text('Countries not found.'));
              create = true;
            } else {
              create = false;
              textoInicial = result.data["comentarioById"]["comentario"];
            }
            return TextFormField(
              onChanged: (text) {
                comentariotxt = text;
              },
              maxLines: 5,
              initialValue: textoInicial,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Comentario',
              ),
            );
            //return _buildList(result);
          },
        ),
        FlatButton(
          color: Colors.blue,
          textColor: Colors.white,
          disabledColor: Colors.grey,
          disabledTextColor: Colors.black,
          padding: EdgeInsets.all(8.0),
          splashColor: Colors.blueAccent,
          onPressed: () {
            print("ayuda");
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CargaComentarioUI())) ;
          },
          child: Text(
            "Comentar",
            style: TextStyle(fontSize: 20.0),
          ),
        )
      ],
    ));
  }


}
