import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'navigator.dart';



void main() {
  runApp(const ShopApp());
}

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopApp',
      onGenerateRoute: onGenerateRoute,
      //onGenerateRoute: generateRoutes,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      //home: TheShopApp(),
    );
  }
}



class FirstSeen extends StatefulWidget {
  //const Main_page_screen({super.key});
  @override
  State<FirstSeen> createState() => _FirstSeenState();
}
class _FirstSeenState extends State<FirstSeen> {

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacementNamed("/Catalog_screen");
      //закоментить нижнюю строчку чтобы онбординг появлялся только 1 при первом входе а не через раз
      prefs.setBool('seen', false);
      //Navigator.pushNamed(context, "/");

    } else {
      prefs.setBool('seen', true);
      Navigator.pushReplacementNamed(context, "/Onbording_screen");
    }
  }

  @override
  void initState() {
    super.initState();
    new Timer(new Duration(milliseconds: 200), () {
      checkFirstSeen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text('Loading...'),
      ),
    );
  }

}