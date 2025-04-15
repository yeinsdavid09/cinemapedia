import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  //#region ----------------------------------- Variables ---------------------------------

  static const String routeName = 'home_screen';

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  const HomeScreen({super.key});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Home')),
        body: Center(child: Text('Home Screen')),
      ),
    );
  }

  //#endregion
}
