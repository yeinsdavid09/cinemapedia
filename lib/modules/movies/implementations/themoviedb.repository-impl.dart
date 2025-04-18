//* Repository
import '../domain/movies.repository.dart';

//* Datasource
import '../domain/movies.datasource.dart';

//* Entities
import '../domain/movies.entity.dart';

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

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming(page: page);
  }

  @override
  Future<Movie> getMovieById({required String id}) {
    return datasource.getMovieById(id: id);
  }

  //#endregion
}
