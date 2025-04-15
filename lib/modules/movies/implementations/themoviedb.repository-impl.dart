//* Repository
import 'package:cinemapedia/modules/movies/domain/movies.repository.dart';

//* Datasource
import 'package:cinemapedia/modules/movies/domain/movies.datasource.dart';

//* Entities
import 'package:cinemapedia/modules/movies/domain/movies.entity.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  //#region ----------------------------------- Variables ---------------------------------

  final MoviesDatasource datasource;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  MoviesRepositoryImpl({required this.datasource});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

  //#endregion
}
