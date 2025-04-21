import 'package:flutter/material.dart';

class AppNavigationBarWidget extends StatelessWidget {
  //#region --------------------------------- Hooks ---------------------------------

  const AppNavigationBarWidget({super.key});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_important),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_rounded),
          label: 'Favorites',
        ),
      ],
    );
  }

  //#endregion
}
