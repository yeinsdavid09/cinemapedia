//* Repository
import './local_storage.repository.dart';

//* Datasource
import '../datasources/local_storage.datasource.dart';

//* Entities
import '../entities/movie.dart';

class LocalStorageRepositoryImpl implements LocalStorageRepository {
  //#region ----------------------------------- Variables ---------------------------------

  final LocalStorageDatasource datasource;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  LocalStorageRepositoryImpl({required this.datasource});

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
