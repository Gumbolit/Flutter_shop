import 'package:flutter/material.dart';

class CustomBotumBar extends StatelessWidget {
  const CustomBotumBar({
    super.key,
    required int Index,
  }) : _Index = Index;

  final int _Index;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              print("IconButton1 onPressed");
              Navigator.pushNamed(context, "/Catalog_screen");
            },
            icon: _Index == 0
                ? const Icon(
              Icons.border_all_rounded,
              color: Colors.black,
              //size: 35,
            )
                : const Icon(
              Icons.border_all_outlined,
              color: Colors.black38,
              //size: 35,
            ),),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              print("IconButton2 onPressed");
              Navigator.pushNamed(context, "/Search_screen");
            },
            icon: _Index == 1
                ? const Icon(
              Icons.search_rounded,
              color: Colors.black,
              //size: 35,
            )
                : const Icon(
              Icons.search_outlined,
              color: Colors.black38,
              //size: 35,
            ),),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              print("IconButton1 onPressed");
              Navigator.pushNamed(context, "/Shopping_cart_screen");
            },
            icon: _Index == 2
                ? const Icon(
              Icons.shopping_bag_rounded,
              color: Colors.black,
              //size: 35,
            )
                : const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.black38,
              //size: 35,
            ),),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              print("IconButton2 onPressed");
              Navigator.pushNamed(context, "/Favourites_screen");
            },
            icon: _Index == 3
                ? const Icon(
              Icons.favorite_border_rounded,
              color: Colors.black,
              //size: 35,
            )
                : const Icon(
              Icons.favorite_border_outlined,
              color: Colors.black38,
              //size: 35,
            ),),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              print("IconButton1 onPressed");
              Navigator.pushNamed(context, "/User_profile_screen");
            },
            icon: _Index == 4
                ? const Icon(
              Icons.account_circle_rounded,
              color: Colors.black,
              //size: 35,
            )
                : const Icon(
              Icons.account_circle_outlined,
              color: Colors.black38,
              //size: 35,
            ),),

        ],
      ),
    );
  }
}