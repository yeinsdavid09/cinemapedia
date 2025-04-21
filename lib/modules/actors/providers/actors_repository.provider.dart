import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Repository
import '../domain/actors.repository-impl.dart';

//* Datasources
import '../datasources/the_movie_db/infrastructure/themoviedb.datasource.dart';

final actorsRepositoryProvider = Provider((ref) {
  return ActorsRepositoryImpl(datasource: TheMovieDBDatasource());
});
