import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Configs
import 'package:cinemapedia/config/index.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const ProviderScope(child: MyApp()));
}

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
