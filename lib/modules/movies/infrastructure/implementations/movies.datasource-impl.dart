import 'package:dio/dio.dart';

//* Configs
import 'package:cinemapedia/config/index.dart';

//* Domain
import '../../domain/index.dart';

//* Models
import '../models/movies.model.dart';
import '../models/details.model.dart';

//* Mappers
import '../mappers/movies.mapper.dart';

class MoviesDatasourceImpl implements MoviesDatasource {
  //#region ----------------------------------- Variables ---------------------------------

  final dio = Dio(
    BaseOptions(
      baseUrl: Environments.theMovieDbApi,
      queryParameters: {
        'api_key': Environments.theMovieDbKey,
        'language': 'es-Mx',
      },
      validateStatus: (status) => status != null && status < 500,
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
    final movie = DetailsResponse.fromJson(response.data);
    return MoviesMapper.detailsFromTheMovieDbToMovie(movie);
  }

  @override
  Future<List<Movie>> getMovieByQuery({required String query}) async {
    if (query.isEmpty) return [];
    final response = await dio.get(
      '/search/movie',
      queryParameters: {'query': query},
    );
    if (response.statusCode != 200) throw Exception('Movie $query not found');
    return _mappingMovies(response.data);
  }

  List<Movie> _mappingMovies(Map<String, dynamic> json) {
    final theMovieDBResponse = MoviesResponse.fromJson(json);
    List<Movie> movies =
        theMovieDBResponse.results
            .where((e) => e.posterPath != 'not-found')
            .map((e) => MoviesMapper.movieFromTheMovieDbToMovie(e))
            .toList();
    return movies;
  }

  //#endregion
}
