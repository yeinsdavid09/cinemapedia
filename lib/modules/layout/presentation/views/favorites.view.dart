import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Providers
import 'package:cinemapedia/modules/movies/index.dart';

class FavoritesView extends ConsumerStatefulWidget {
  //#region --------------------------------- Hooks ---------------------------------

  const FavoritesView({super.key});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  _FavoritesViewState createState() => _FavoritesViewState();

  //#endregion
}

class _FavoritesViewState extends ConsumerState<FavoritesView> {
  //#region --------------------------------- Variables ---------------------------------

  bool moviesAreLoading = false;
  bool isLastPage = false;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  @override
  void initState() {
    super.initState();
    ref.read(favoritesMoviesProvider.notifier).loadNextPage();
  }

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  loadNextPage() async {
    if (moviesAreLoading || isLastPage) return;
    moviesAreLoading = true;
    final movies =
        await ref.read(favoritesMoviesProvider.notifier).loadNextPage();
    moviesAreLoading = false;
    if (movies.isEmpty) isLastPage = true;
  }

  @override
  Widget build(BuildContext context) {
    //#region --------------------------------- Variables ---------------------------------

    final favoritesMovies = ref.watch(favoritesMoviesProvider).values.toList();

    //#endregion

    //#region --------------------------------- Return ---------------------------------

    return Scaffold(
      body:
          favoritesMovies.isEmpty
              ? const Center(
                child: Text('Ups... Aún no tienes peliculas favoritas'),
              )
              : Padding(
                padding: const EdgeInsets.all(10),
                child: MoviesMasonryWidget(
                  movies: favoritesMovies,
                  loadNextPage: loadNextPage,
                ),
              ),
    );

    //#endregion
  }

  //#endregion
}
