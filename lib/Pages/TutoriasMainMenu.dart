import 'package:flutter/material.dart';
import 'package:flutter_app_prueba_uno/Cargas/CargaLogin.dart';
import 'package:flutter_app_prueba_uno/Common/TutoriasAppBar.dart';
import 'package:flutter_app_prueba_uno/LogIn_Home.dart';
import 'package:flutter_app_prueba_uno/Pages/Agendadas.dart';
import 'package:flutter_app_prueba_uno/Pages/MisTutorias.dart';
import 'package:flutter_app_prueba_uno/Pages/Perfil.dart';
import 'package:flutter_app_prueba_uno/Pages/VerTutorias.dart';
import 'package:flutter_app_prueba_uno/Util/ScreenUtil.dart';
import 'package:flutter_app_prueba_uno/singletonInstance/UserSingleton.dart';

class TutoriasMainMenu extends StatelessWidget {

  _goToProfile(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PerfilUI()));
  }

  _goToLookUpTutoria(BuildContext context) {
    UserSingleton().appBar = true;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => VerTutoriasUI()));
  }

  _goToMyTutoria(BuildContext context) {
    UserSingleton().appBar = true;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MisTutoriasUI()));
  }

  _goToAgnTutoria(BuildContext context) {
    UserSingleton().appBar = true;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AgendadasUI()));
  }

  _goToLogInHome(context){
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LogIn()));
  }

  @override
  Widget build(BuildContext context) {
    var space = SizedBox(height: getHeightWithoutSafeArea(context) * 0.05);
    var smallSpace = SizedBox(height: getHeightWithoutSafeArea(context) * 0.02);

    double buttonWith = 0.8;
    var profileButton = Container(
      height: getHeightWithoutSafeArea(context) * 0.07,
      width: getFullScreenWidth(context) * buttonWith,
      child: FlatButton(
        color: Colors.lightGreen,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.person),
            SizedBox(width: getFullScreenWidth(context) * 0.03,),
            Text("Cuenta",
                style: TextStyle(
                    letterSpacing: 3.0, color: Colors.white, fontSize: 18)),
          ],
        ),
        onPressed: () {
          _goToProfile(context);
        },
      ),
    );

    var lookUpTutoriaButton = Container(
      height: getHeightWithoutSafeArea(context) * 0.07,
      width: getFullScreenWidth(context) * buttonWith,
      child: FlatButton(
        color: Colors.lightGreen,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.remove_red_eye),
            SizedBox(width: getFullScreenWidth(context) * 0.03,),
            Text("Ver Tutorias",
                style: TextStyle(
                    letterSpacing: 3.0, color: Colors.white, fontSize: 18)),
          ],
        ),
        onPressed: () {
          _goToLookUpTutoria(context);
        },
      ),
    );
    var myTutoriaButton = Container(
      height: getHeightWithoutSafeArea(context) * 0.07,
      width: getFullScreenWidth(context) * buttonWith,
      child: FlatButton(
        color: Colors.lightGreen,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.more_horiz),
            SizedBox(width: getFullScreenWidth(context) * 0.03,),
            Text("Mis Tutorias",
                style: TextStyle(
                    letterSpacing: 3.0, color: Colors.white, fontSize: 18)),
          ],
        ),
        onPressed: () {
          _goToMyTutoria(context);
        },
      ),
    );
    var agenTutoriaButton = Container(
      height: getHeightWithoutSafeArea(context) * 0.07,
      width: getFullScreenWidth(context) * buttonWith,
      child: FlatButton(
        color: Colors.lightGreen,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.assignment),
            SizedBox(width: getFullScreenWidth(context) * 0.03,),
            Text("Tutorias Agendadas",
                style: TextStyle(
                    letterSpacing: 3.0, color: Colors.white, fontSize: 18)),
          ],
        ),
        onPressed: () {
          _goToAgnTutoria(context);
        },
      ),
    );

    var endSesionButton = Container(
      height: getHeightWithoutSafeArea(context) * 0.07,
      width: getFullScreenWidth(context) * 0.6,
      child: FlatButton(
        color: Colors.deepOrange,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.close),
            SizedBox(width: getFullScreenWidth(context) * 0.03,),
            Text("Cerrar Sesion",
                style: TextStyle(
                    letterSpacing: 3.0, color: Colors.white, fontSize: 18)),
          ],
        ),
        onPressed: () {
          _goToLogInHome(context);
        },
      ),
    );


    return Scaffold(
        //appBar: TutoriasAppBar().build(context),
        body: SingleChildScrollView(
          child: Container(
            height: getHeightWithoutSafeArea(context) * (1 - 0.1),
            width: getFullScreenWidth(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                space,space,space,

                profileButton,
                space,
                lookUpTutoriaButton,
                space,
                myTutoriaButton,
                space,
                agenTutoriaButton,
                space,space,
                endSesionButton
              ],
            ),
          ),
        ));
  }
}
