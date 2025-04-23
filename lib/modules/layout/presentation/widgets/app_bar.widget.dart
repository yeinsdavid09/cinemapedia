import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

//* Movies
import 'package:cinemapedia/modules/movies/index.dart';

class AppBarWidget extends ConsumerWidget {
  //#region --------------------------------- Hooks ---------------------------------

  const AppBarWidget({super.key});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //#region ----------------------------------- Variables ---------------------------------

    final colors = Theme.of(context).colorScheme;
    final texts = Theme.of(context).textTheme;
    final searchCallback =
        ref.read(searchMoviesProvider.notifier).getMovieByQuery;

    //#endregion

    //#region --------------------------------- Return ---------------------------------

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Icon(Icons.movie_creation_outlined, color: colors.primary),
            const SizedBox(width: 5),
            Text('Cinemapedia', style: texts.titleMedium),
            const Spacer(),
            IconButton(
              onPressed: () {
                final searchQuery = ref.read(searchQueryProvider);
                final searchedMovies = ref.read(searchMoviesProvider);
                showSearch<Movie?>(
                  query: searchQuery,
                  context: context,
                  delegate: MovieSearchDelegate(
                    initialData: searchedMovies,
                    searchCallback: ({required String query}) {
                      return searchCallback(query: query);
                    },
                  ),
                ).then((movie) {
                  if (!context.mounted || movie == null) return;
                  context.push('/movie/${movie.id}');
                });
              },
              icon: const Icon(Icons.search_outlined),
            ),
          ],
        ),
      ),
    );

    //#endregion
  }

  //#endregion
}
