import 'package:flutter/material.dart';


double getFullScreenWidth(BuildContext context){
  return MediaQuery.of(context).size.width;
}

double getFullScreenHeight(BuildContext context){
  return MediaQuery.of(context).size.height;
}

double getHeightWithoutSafeArea(BuildContext context){
  var padding = MediaQuery.of(context).padding;
  return MediaQuery.of(context).size.height - padding.top - padding.bottom;
}

double getHeightWithoutStatusBar(BuildContext context){
  var padding = MediaQuery.of(context).padding;
  return MediaQuery.of(context).size.height -padding.top;
}

double getHeightWithoutStatusAndToolBar(BuildContext context){
  var padding = MediaQuery.of(context).padding;
  return MediaQuery.of(context).size.height -padding.top - kToolbarHeight;
}
