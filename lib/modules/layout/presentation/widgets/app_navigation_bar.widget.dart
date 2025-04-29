import 'package:flutter/material.dart';

class AppNavigationBarWidget extends StatelessWidget {
  //#region --------------------------------- Variables ---------------------------------

  final int currentIndex;
  final ValueChanged<int> onTap;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  const AppNavigationBarWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
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
