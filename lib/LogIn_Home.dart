import 'package:flutter/material.dart';
import 'package:flutter_app_prueba_uno/Cargas/CargaLogin.dart';
import 'package:flutter_app_prueba_uno/Common/TutoriasAppBar.dart';
import 'package:flutter_app_prueba_uno/Pages/SignInOne.dart';
import 'package:flutter_app_prueba_uno/Pages/TutoriasMainMenu.dart';
import 'package:flutter_app_prueba_uno/Util/ScreenUtil.dart';
import 'package:flutter_app_prueba_uno/singletonInstance/UserSingleton.dart';

class LogIn extends StatelessWidget {
  _goToLogIn(BuildContext context) {
    Navigator.push(
       context, MaterialPageRoute(builder: (context) => TutoriasMainMenu()));
  }

  _goToSignIn(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignInOne()));
  }

  var singletonUserInstance = UserSingleton();
  double hintSize = 18.0;

  @override
  Widget build(BuildContext context) {
    var space = SizedBox(height: getHeightWithoutSafeArea(context) * 0.05);
    var smallSpace = SizedBox(height: getHeightWithoutSafeArea(context) * 0.02);
    var emailField = Container(
      width: getFullScreenWidth(context) * 0.7,
      child: TextField(
        style: TextStyle(color: Colors.grey),
        onChanged: (text) {
          singletonUserInstance.email = text;
          print(text);
        },
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            hintText: "EMAIL",
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(),
            ),
            hintStyle: TextStyle(color: Colors.grey, fontSize: hintSize)),
      ),
    );

    var passwordField = Container(
      width: getFullScreenWidth(context) * 0.7,
      child: TextField(
        obscureText: true,
        style: TextStyle(color: Colors.grey),
        onChanged: (text) {
          singletonUserInstance.password = text;
          print(text);
        },
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            hintText: "CONTRASEÑA",
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(),
            ),
            hintStyle: TextStyle(color: Colors.grey, fontSize: hintSize)),
      ),
    );

    var logInButton = Container(
      height: getHeightWithoutSafeArea(context) * 0.07,
      width: getFullScreenWidth(context) * 0.5,
      child: FlatButton(
        color: Colors.lightGreen,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Text("Log In",
            style: TextStyle(
                letterSpacing: 3.0, color: Colors.white, fontSize: 18)),
        onPressed: () {
          _goToLogIn(context);
        },
      ),
    );

    var signUpButton = Container(
      height: getHeightWithoutSafeArea(context) * 0.07,
      width: getFullScreenWidth(context) * 0.5,
      child: FlatButton(
        color: Colors.deepOrange,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Text("Registrarse",
            style: TextStyle(
                letterSpacing: 3.0, color: Colors.white, fontSize: 18)),
        onPressed: () {
          _goToSignIn(context);
        },
      ),
    );
    return Scaffold(
        appBar: TutoriasAppBar().build(context),
        body: SingleChildScrollView(
          child: Container(
            height: getHeightWithoutSafeArea(context) * (1 - 0.1),
            width: getFullScreenWidth(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                space,
                Text(
                  "UNTutor",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
                ),
                space,
                space,
                emailField,
                smallSpace,
                passwordField,
                space,
                logInButton,
                smallSpace,
                signUpButton
              ],
            ),
          ),
        ));
  }
}
