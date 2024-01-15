import 'package:flutter/material.dart';
import 'features/main_page/main_page_screen.dart';
import 'features/onbording/onbording_screen.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings){
  if (settings.name=="/Onbording_screen"){
    return MaterialPageRoute(builder: (context) => Onbording_screen());
  } else if (settings.name=="/"){
    return MaterialPageRoute(builder: (context) => FirstSeen());
  } else if (settings.name=="/Main_page_screen"){
    return MaterialPageRoute(builder: (context) => Main_page_screen());
  }

}