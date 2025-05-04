//* Entities
import '../../../movies/domain/entities/movie.dart';

abstract class FavoritesDatasource {
  //#region --------------------------------- Methods ---------------------------------

  Future<Movie> toggleMovie({required Movie movie});
  Future<bool> isFavorite({required int movieId});
  Future<List<Movie>> loadFavoritesMovies({int limit = 12, int offset = 0});

  //#endregion
}
