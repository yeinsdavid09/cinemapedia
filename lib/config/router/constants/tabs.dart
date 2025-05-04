import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//* Views
import 'package:cinemapedia/modules/layout/index.dart';

class RouterConstants {
  //#region --------------------------------- Variables ---------------------------------

  static const List<String> tabs = ['home', 'categories', 'favorites'];
  static const List<Widget> views = [
    HomeView(),
    CategoriesView(),
    FavoritesView(),
  ];

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  static void navigateToView(BuildContext context, int index) {
    if (index < 0 || index >= tabs.length) return;

    final tab = tabs[index];
    context.go('/app/$tab');
  }

  static int indexOfView(String view) {
    if (!tabs.contains(view)) return 0;
    return tabs.indexOf(view);
  }

  //#endregion
}
