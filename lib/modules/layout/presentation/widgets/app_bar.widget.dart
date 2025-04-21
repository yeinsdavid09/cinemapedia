import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  //#region --------------------------------- Hooks ---------------------------------

  const AppBarWidget({super.key});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Widget build(BuildContext context) {
    //#region ----------------------------------- Variables ---------------------------------

    final colors = Theme.of(context).colorScheme;
    final texts = Theme.of(context).textTheme;

    //#endregion

    //#region --------------------------------- Return ---------------------------------

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Icon(Icons.movie_creation_outlined, color: colors.primary),
            SizedBox(width: 5),
            Text('Cinemapedia', style: texts.titleMedium),
            Spacer(),
            IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined)),
          ],
        ),
      ),
    );

    //#endregion
  }

  //#endregion
}
