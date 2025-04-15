//* Entities
import 'package:cinemapedia/modules/movies/domain/movies.entity.dart';

abstract class MoviesDatasource {
  //#region --------------------------------- Methods ---------------------------------

  Future<List<Movie>> getNowPlaying({int page = 1});

  //#endregion
}
