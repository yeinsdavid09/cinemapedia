import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Repository
import '../domain/movies.repository-impl.dart';

//* Datasources
import '../datasources/the_movie_db/infrastructure/themoviedb.datasource.dart';

final moviesRepositoryProvider = Provider((ref) {
  return MoviesRepositoryImpl(datasource: TheMovieDBDatasource());
});
