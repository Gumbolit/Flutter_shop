import 'package:flutter/material.dart';

import '../../custom_wiget/custom_boyum_navigator.dart';

class Shopping_cart_screen extends StatelessWidget {
  const Shopping_cart_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            'SHOPPING CART',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      //backgroundColor: Colors.black,
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text("Shopping_cart_screen", /*style: TextStyle(color: Colors.white)*/),
            //CustomBotumBar(Index: 0),
          ]),
        ),
        bottomNavigationBar: CustomBotumBar(Index: 2));
  }
}