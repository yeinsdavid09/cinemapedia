import 'package:dio/dio.dart';

//* Configs
import 'package:cinemapedia/config/index.dart';

//* Datasources
import 'package:cinemapedia/modules/movies/domain/movies.datasource.dart';

//* Entities
import 'package:cinemapedia/modules/movies/domain/movies.entity.dart';

//* Models
import 'package:cinemapedia/modules/movies/models/the_movie_db/themoviedb.model.dart';

//* Mappers
import 'package:cinemapedia/modules/movies/mappers/movies.mapper.dart';

class TheMovieDBDatasource implements MoviesDatasource {
  //#region ----------------------------------- Variables ---------------------------------

  final dio = Dio(
    BaseOptions(
      baseUrl: Environments.theMovieDbApi,
      queryParameters: {
        'api_key': Environments.theMovieDbKey,
        'language': 'es-Mx',
      },
    ),
  );

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing');
    final theMovieDBResponse = TheMovieDBResponse.fromJson(response.data);
    List<Movie> movies =
        theMovieDBResponse.results
            .where((e) => e.posterPath != 'not-found')
            .map((e) => MoviesMapper.movieFromTheMovieDbToMovie(e))
            .toList();
    return movies;
  }

  //#endregion
}
