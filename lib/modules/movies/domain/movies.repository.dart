//* Entities
import 'package:cinemapedia/modules/movies/domain/movies.entity.dart';

abstract class MoviesRepository {
  //#region --------------------------------- Methods ---------------------------------

  Future<List<Movie>> getNowPlaying({int page = 1});

  //#endregion
}
