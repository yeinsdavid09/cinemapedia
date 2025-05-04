import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Repository
import '../implementations/movies.repository-impl.dart';

//* Datasources
import '../implementations/movies.datasource-impl.dart';

final moviesRepositoryProvider = Provider((ref) {
  return MoviesRepositoryImpl(datasource: MoviesDatasourceImpl());
});
