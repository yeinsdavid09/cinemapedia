import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class AppLoader extends StatelessWidget {
  //#region ----------------------------------- Variables ---------------------------------

  final List<String> messages = [
    'Comprando boletos',
    'Comprando palomitas',
    'Cargando Peliculas',
  ];

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  AppLoader({super.key});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  Stream<String> getMessages() {
    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    //#region ----------------------------------- Variables ---------------------------------

    final colors = Theme.of(context).colorScheme;
    final texts = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    //#endregion

    //#region --------------------------------- Return ---------------------------------

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                FadeInDown(
                  child: Icon(Icons.movie_outlined, color: colors.primary),
                ),
                StreamBuilder(
                  stream: getMessages(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return FadeIn(
                        child: Text('Cargando...', style: texts.bodyLarge),
                      );
                    }

                    return FadeIn(
                      child: Text(snapshot.data!, style: texts.bodyLarge),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );

    //#endregion
  }

  //#endregion
}
