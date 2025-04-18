import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Entities
import 'package:cinemapedia/modules/movies/domain/movies.entity.dart';

//* Providers
import 'package:cinemapedia/modules/movies/providers/movies_repository.provider.dart';

final nowPlayingMoviesProvider = StateNotifierProvider((ref) {
  final movieCallBack = ref.watch(moviesRepositoryProvider).getNowPlaying;
  return MoviesNotifier(movieCallBack: movieCallBack);
});

final popularMoviesProvider = StateNotifierProvider((ref) {
  final movieCallBack = ref.watch(moviesRepositoryProvider).getPopular;
  return MoviesNotifier(movieCallBack: movieCallBack);
});

final topRatedMoviesProvider = StateNotifierProvider((ref) {
  final movieCallBack = ref.watch(moviesRepositoryProvider).getTopRated;
  return MoviesNotifier(movieCallBack: movieCallBack);
});

final upcomingMoviesProvider = StateNotifierProvider((ref) {
  final movieCallBack = ref.watch(moviesRepositoryProvider).getUpcoming;
  return MoviesNotifier(movieCallBack: movieCallBack);
});

typedef MovieCallBack = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  //#region ----------------------------------- Variables ---------------------------------

  int currentPage = 0;
  bool moviesAreLoading = false;
  MovieCallBack movieCallBack;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  MoviesNotifier({required this.movieCallBack}) : super([]);

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  Future<void> loadNextPage() async {
    if (moviesAreLoading) return;
    moviesAreLoading = true;
    currentPage++;
    final List<Movie> movies = await movieCallBack(page: currentPage);
    state = [...state, ...movies];
    await Future.delayed(const Duration(milliseconds: 500));
    moviesAreLoading = false;
  }

  //#endregion
}
