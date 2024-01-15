

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*class Main_page_screen extends StatelessWidget {

  static const first_visit_key = "first_visit_key";

  const Main_page_screen({
    super.key,
  });

  Future<bool> Visit() async {
    var first_visit =await SharedPreferences.getInstance();
    first_visit.getBool(first_visit_key);
    return first_visit.getBool(first_visit_key) ?? true;
  }

  @override
  Widget build(BuildContext context) {

    var first_visit = SharedPreferences.getInstance();

    return Scaffold(
      //appBar: AppBar(),
      body: Center(
        child: Text("new screen"),
      ),
    );
  }
}*/


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
      Navigator.of(context).pushReplacementNamed("/Main_page_screen");
      //prefs.setBool('seen', false);
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


class Main_page_screen extends StatefulWidget {
  const Main_page_screen({super.key});

  @override
  State<Main_page_screen> createState() => _Main_page_screenState();
}
class _Main_page_screenState extends State<Main_page_screen> {

  var _selectPageIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("asset/logo/AppBarLogo.png", width: 130, height: 50),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Main_page_screen"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black38,
        selectedItemColor: Colors.black,
        showUnselectedLabels: true,
        currentIndex: _selectPageIndex,
        onTap: _openPage,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.border_all), label: "Витрина"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Каталог"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "Корзина"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "Избранное"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Профиль"),
        ],
      ),
    );
  }
  void _openPage(int index) {
    setState(() {
      _selectPageIndex=index;
    });
  }
}


