import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

//* Entities
import '../../../domain/entities/movie.dart';

//* Datasources
import '../../../domain/datasources/local_storage.datasource.dart';

class IsarDatasource implements LocalStorageDatasource {
  //#region --------------------------------- Variables ---------------------------------

  late Future<Isar> _db;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  IsarDatasource() {
    _db = openDb();
  }

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  Future<Isar> openDb() async {
    final dir = await getApplicationDocumentsDirectory();
    return Isar.open(
      schemas: [MovieSchema],
      directory: dir.path,
      inspector: true,
    );
  }

  @override
  Future<bool> isFavorite({required int movieId}) async {
    final isar = await _db;
    final movieExist = isar.movies.where().idEqualTo(movieId).findFirst();
    return movieExist != null;
  }

  @override
  Future<List<Movie>> loadFavoritesMovies({
    int limit = 12,
    int offset = 0,
  }) async {
    final isar = await _db;
    final List<Movie> movies = isar.movies.where().findAll(
      limit: limit,
      offset: offset,
    );
    return movies;
  }

  @override
  Future<Movie> toggleMovie({required Movie movie}) async {
    final isar = await _db;
    final Movie? movieExist =
        isar.movies.where().idEqualTo(movie.id).findFirst();

    if (movieExist != null) {
      isar.write((_) => isar.movies.delete(movieExist.id));
    } else {
      isar.write((_) => isar.movies.put(movie));
    }

    return movie;
  }

  //#endregion
}
