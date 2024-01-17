import 'package:flutter/material.dart';
import 'features/catalog/catalog_screen.dart';
import 'features/favourites/favourites_screen.dart';
import 'features/main_page/main_page_screen.dart';
import 'features/onbording/onbording_screen.dart';
import 'features/search/search_screen.dart';
import 'features/shopping_cart/shopping_cart_screen.dart';
import 'features/user_profile/user_profile_screen.dart';
import 'main.dart';



Route<dynamic>? onGenerateRoute(RouteSettings settings){
  if (settings.name=="/"){
    return MaterialPageRoute(builder: (context) => FirstSeen());
  }

  else if (settings.name=="/Onbording_screen"){
    return MaterialPageRoute(builder: (context) => Onbording_screen());
  }

  else if (settings.name=="/Main_page_screen"){
    return MaterialPageRoute(builder: (context) => Main_page_screen());
  }

  else if (settings.name=="/Catalog_screen"){
    return MaterialPageRoute(builder: (context) => Catalog_screen());
  }

  else if (settings.name=="/Search_screen"){
    return MaterialPageRoute(builder: (context) => Search_screen());
  }

  else if (settings.name=="/Shopping_cart_screen"){
    return MaterialPageRoute(builder: (context) => Shopping_cart_screen());
  }

  else if (settings.name=="/Favourites_screen"){
    return MaterialPageRoute(builder: (context) => Favourites_screen());
  }

  else if (settings.name=="/User_profile_screen"){
    return MaterialPageRoute(builder: (context) => User_profile_screen());
  }


}