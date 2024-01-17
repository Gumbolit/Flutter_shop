import 'package:flutter/material.dart';

import '../../custom_wiget/custom_boyum_navigator.dart';

class Favourites_screen extends StatelessWidget {
  const Favourites_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text("Favourites_screen", /*style: TextStyle(color: Colors.white)*/),
            //CustomBotumBar(Index: 0),
          ]),
        ),
        bottomNavigationBar: CustomBotumBar(Index: 3));
  }
}