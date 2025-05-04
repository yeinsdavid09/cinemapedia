import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Entities
import '../domain/entities/movie.dart';

//* Providers
import './movies.provider.dart';

final moviesSliderProvider = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
  if (nowPlayingMovies.isEmpty) return [];
  return nowPlayingMovies.sublist(0, 10);
});
