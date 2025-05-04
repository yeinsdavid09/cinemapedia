//* Repository
import '../../domain/contracts/favorites.repository.dart';

//* Datasource
import '../../domain/contracts/favorites.datasource.dart';

//* Entities
import '../../../movies/domain/entities/movie.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  //#region ----------------------------------- Variables ---------------------------------

  final FavoritesDatasource datasource;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  FavoritesRepositoryImpl({required this.datasource});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Future<bool> isFavorite({required int movieId}) {
    return datasource.isFavorite(movieId: movieId);
  }

  @override
  Future<List<Movie>> loadFavoritesMovies({int limit = 12, int offset = 0}) {
    return datasource.loadFavoritesMovies(limit: limit, offset: offset);
  }

  @override
  Future<Movie> toggleMovie({required Movie movie}) {
    return datasource.toggleMovie(movie: movie);
  }

  //#endregion
}
