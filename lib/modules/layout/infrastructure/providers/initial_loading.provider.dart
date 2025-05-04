import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Providers
import 'package:cinemapedia/modules/movies/infrastructure/index.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final popularMovies = ref.watch(popularMoviesProvider).isEmpty;
  final topRatedMovies = ref.watch(topRatedMoviesProvider).isEmpty;
  final upcomingMovies = ref.watch(upcomingMoviesProvider).isEmpty;

  if (nowPlayingMovies || popularMovies || topRatedMovies || upcomingMovies) {
    return true;
  }

  return false;
});
