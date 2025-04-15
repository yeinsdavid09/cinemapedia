import 'package:cinemapedia/config/router/routes/app.routes.dart';
import 'package:flutter/material.dart';

//* Configs
import 'package:cinemapedia/config/index.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  //#region --------------------------------- Hooks ---------------------------------

  const MyApp({super.key});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'Cinemapedia',
      debugShowCheckedModeBanner: false,
      theme: AppTheme(color: 0, brightness: Brightness.light).getTheme(),
    );
  }

  //#endregion
}
