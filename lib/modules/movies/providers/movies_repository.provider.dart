import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Repository
import 'package:cinemapedia/modules/movies/implementations/themoviedb.repository-impl.dart';

//* Datasources
import 'package:cinemapedia/modules/movies/infrastructure/the_movie_db/themoviedb.datasource.dart';

final moviesRepositoryProvider = Provider((ref) {
  return MoviesRepositoryImpl(datasource: TheMovieDBDatasource());
});
