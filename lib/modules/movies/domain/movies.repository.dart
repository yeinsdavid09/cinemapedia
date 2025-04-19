//* Entities
import './movies.entity.dart';

abstract class MoviesRepository {
  //#region --------------------------------- Methods ---------------------------------

  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1});
  Future<List<Movie>> getUpcoming({int page = 1});
  Future<Movie> getMovieById({required String id});

  //#endregion
}
