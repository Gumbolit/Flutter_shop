import 'package:flutter/material.dart';

import '../../custom_wiget/custom_boyum_navigator.dart';

class User_profile_screen extends StatelessWidget {
  const User_profile_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text("User_profile_screen", /*style: TextStyle(color: Colors.white)*/),
            //CustomBotumBar(Index: 0),
          ]),
        ),
        bottomNavigationBar: CustomBotumBar(Index: 4));
  }
}