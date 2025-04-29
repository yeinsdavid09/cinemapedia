import 'package:flutter/material.dart';

//* Configs
import 'package:cinemapedia/config/index.dart';

//* Widgets
import '../widgets/app_navigation_bar.widget.dart';

class LayoutScreen extends StatelessWidget {
  //#region ----------------------------------- Variables ---------------------------------

  static const String routeName = 'layout_screen';
  final String currentView;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  const LayoutScreen({super.key, required this.currentView});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Widget build(BuildContext context) {
    //#region --------------------------------- Variables ---------------------------------

    final index = RouterConstants.indexOfView(currentView);

    //#endregion

    //#region --------------------------------- Return ---------------------------------

    return SafeArea(
      child: Scaffold(
        body: IndexedStack(index: index, children: RouterConstants.views),
        bottomNavigationBar: AppNavigationBarWidget(
          currentIndex: index,
          onTap: (value) => RouterConstants.navigateToView(context, value),
        ),
      ),
    );

    //#endregion
  }

  //#endregion
}
