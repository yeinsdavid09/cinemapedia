//* Repository
import './movies.repository.dart';

//* Datasource
import './movies.datasource.dart';

//* Entities
import './movies.entity.dart';

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

  @override
  Future<List<Movie>> getMovieByQuery({required String query}) {
    return datasource.getMovieByQuery(query: query);
  }

  //#endregion
}
