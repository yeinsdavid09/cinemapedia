import 'package:dio/dio.dart';

//* Configs
import 'package:cinemapedia/config/index.dart';

//* Datasources
import '../../domain/movies.datasource.dart';

//* Entities
import '../../domain/movies.entity.dart';

//* Models
import '../../models/the_movie_db/themoviedb.model.dart';
import '../../models/the_movie_db/movie_details.model.dart';

//* Mappers
import '../../mappers/movies.mapper.dart';

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
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {'page': page},
    );
    return _mappingMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get(
      '/movie/popular',
      queryParameters: {'page': page},
    );
    return _mappingMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get(
      '/movie/top_rated',
      queryParameters: {'page': page},
    );
    return _mappingMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get(
      '/movie/upcoming',
      queryParameters: {'page': page},
    );
    return _mappingMovies(response.data);
  }

  @override
  Future<Movie> getMovieById({required String id}) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200) throw Exception('Movie $id not found');
    final movie = TheMovieDBDetails.fromJson(response.data);
    return MoviesMapper.movieFromMovieDetailsToMovie(movie);
  }

  List<Movie> _mappingMovies(Map<String, dynamic> json) {
    final theMovieDBResponse = TheMovieDBResponse.fromJson(json);
    List<Movie> movies =
        theMovieDBResponse.results
            .where((e) => e.posterPath != 'not-found')
            .map((e) => MoviesMapper.movieFromTheMovieDbToMovie(e))
            .toList();
    return movies;
  }

  //#endregion
}
