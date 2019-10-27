import 'package:flutter/material.dart';
import 'package:flutter_app_prueba_uno/Util/ScreenUtil.dart';

class TutoriasAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    @override
    Widget build(BuildContext context) {
      double height = getHeightWithoutSafeArea(context);
      return PreferredSize(
        preferredSize: Size.fromHeight(height * 0.1),
        child: AppBar(
          actions: <Widget>[],
          leading: new Container(),
          backgroundColor: Colors.lightGreen,
          title: Align(
            alignment: Alignment.topRight,
           ),
        ),
      );
    }
  }
}
