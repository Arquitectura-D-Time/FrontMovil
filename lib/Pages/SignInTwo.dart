import 'package:flutter/material.dart';
import 'package:flutter_app_prueba_uno/Common/TutoriasAppBar.dart';
import 'package:flutter_app_prueba_uno/Cargas/Carga.dart';
import 'package:flutter_app_prueba_uno/Util/ScreenUtil.dart';
import 'package:flutter_app_prueba_uno/singletonInstance/UserSingleton.dart';

class SignInTwo extends StatelessWidget {
  var singletonUserInstance = UserSingleton();
  var pss1;
  var pss2;

  _goToSignIn(BuildContext context) {
    if (pss1 == pss2 && pss1 != null) {
      singletonUserInstance.password = pss1;
      Navigator.push(
         context, MaterialPageRoute(builder: (context) =>  CargaUI()));
    } else {
      print("Contraseña esta mal");
    }
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = 22;
    double hintSize = 16;

    ///////////////////////////////////

    var space = SizedBox(height: getHeightWithoutSafeArea(context) * 0.05);
    var smallSpace = SizedBox(height: getHeightWithoutSafeArea(context) * 0.02);

    ///////////////////////////////////
    var password1Text = Text("Contraseña",
        style: TextStyle(fontSize: fontSize, color: Colors.deepOrange));
    var password2Text = Text("Repitala",
        style: TextStyle(fontSize: fontSize, color: Colors.deepOrange));

    ////////////////////////////////
    var password1Input = Container(
      width: getFullScreenWidth(context) * 0.7,
      child: TextField(
        obscureText: true,
        style: TextStyle(color: Colors.lightGreen),
        onChanged: (text) {
          pss2 = text;
          print(text);
        },
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            hintText: "Contraseña",
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(color: Colors.white),
            ),
            hintStyle: TextStyle(color: Colors.lightGreen, fontSize: hintSize)),
      ),
    );

    var password2Input = Container(
      width: getFullScreenWidth(context) * 0.7,
      child: TextField(
        obscureText: true,
        style: TextStyle(color: Colors.lightGreen),
        onChanged: (text) {
          pss1 = text;
          print(text);
        },
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            hintText: "Repita su contraseña",
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(color: Colors.white),
            ),
            hintStyle: TextStyle(color: Colors.lightGreen, fontSize: hintSize)),
      ),
    );

    ////////////////////////////////
    var continueSignInButton = Container(
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

    var screen = Scaffold(
      appBar: TutoriasAppBar().build(context),
      body: Container(
        height: getHeightWithoutSafeArea(context) - (0.1),
        width: getFullScreenWidth(context),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            space,
            password1Text,
            smallSpace,
            password1Input,
            space,
            password2Text,
            smallSpace,
            password2Input,
            space,
            continueSignInButton,
          ],
        ),
      ),
    );
    return screen;
  }
}
