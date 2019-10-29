import 'package:flutter/material.dart';
import 'package:flutter_app_prueba_uno/Common/TutoriasAppBar.dart';
import 'package:flutter_app_prueba_uno/Pages/SignInTwo.dart';
import 'package:flutter_app_prueba_uno/Util/ScreenUtil.dart';
import 'package:flutter_app_prueba_uno/singletonInstance/UserSingleton.dart';

class SignInOne extends StatelessWidget {

  var singletonUserInstance = UserSingleton();

  _goToContinueSignIn (BuildContext context){

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignInTwo()));

  }
  @override
  Widget build(BuildContext context) {
    double fontSize = 22;
    double hintSize = 16;

    ///////////////////////////////////

    var space = SizedBox(height: getHeightWithoutSafeArea(context) * 0.05);
    var smallSpace = SizedBox(height: getHeightWithoutSafeArea(context) * 0.02);

    ///////////////////////////////////
    var nameText = Text("Nombre",
        style: TextStyle(fontSize: fontSize, color: Colors.deepOrange));
    var emailText = Text("E-mail",
        style: TextStyle(fontSize: fontSize, color: Colors.deepOrange));
    var nickText =
        Text("Nick", style: TextStyle(fontSize: fontSize, color: Colors.deepOrange));

    ////////////////////////////////
    var nameInput = Container(
      width: getFullScreenWidth(context) * 0.7,
      child: TextField(
        style: TextStyle(color: Colors.lightGreen),
        onChanged: (text) {
          singletonUserInstance.name = text;
          print(text);
        },
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            hintText: "Nombre",
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(color: Colors.white),
            ),
            hintStyle: TextStyle(color: Colors.lightGreen, fontSize: hintSize)),
      ),
    );

    var emailInput = Container(
      width: getFullScreenWidth(context) * 0.7,
      child: TextField(
        style: TextStyle(color: Colors.lightGreen),
        onChanged: (text) {
          singletonUserInstance.email = text;
          print(text);
        },
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            hintText: "E-mail",
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(color: Colors.white),
            ),
            hintStyle: TextStyle(color: Colors.lightGreen, fontSize: hintSize)),
      ),
    );

    var nickInput = Container(
      width: getFullScreenWidth(context) * 0.7,
      child: TextField(
        style: TextStyle(color: Colors.lightGreen),
        onChanged: (text) {
          singletonUserInstance.nickname = text;
          print(text);
        },
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            hintText: "Nick",
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
        child: Text("Continuar",
            style: TextStyle(
                letterSpacing: 3.0,
                color: Colors.white,
                fontSize: 18)),
        onPressed: () {
          _goToContinueSignIn(context);
        },
      ),
    );

    var screen = Scaffold(
      appBar: TutoriasAppBar().build(context),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: getHeightWithoutSafeArea(context) - (0.1),
          width: getFullScreenWidth(context),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              space,
              nameText,
              smallSpace,
              nameInput,
              space,
              emailText,
              smallSpace,
              emailInput,
              space,
              nickText,
              smallSpace,
              nickInput,
              space,
              continueSignInButton,
            ],
          ),
        ),
      )
    );
    return screen;
  }
}
