import 'package:cinemapedia/modules/actors/index.dart';
import 'package:dio/dio.dart';

//* Configs
import 'package:cinemapedia/config/index.dart';

//* Datasources
import '../../../domain/actors.datasource.dart';

//* Entities
import '../../../domain/actors.entity.dart';

//* Models

//* Mappers
import '../../../mappers/actors.mapper.dart';

class TheMovieDBDatasource implements ActorsDatasource {
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
  Future<List<Actor>> getActorsByMovieId({required String id}) async {
    final response = await dio.get('/movie/$id/credits');
    return _mappingMovies(response.data);
  }

  List<Actor> _mappingMovies(Map<String, dynamic> json) {
    final theMovieDBResponse = CreditsResponse.fromJson(json);
    List<Actor> movies =
        theMovieDBResponse.cast
            .map((e) => ActorsMapper.castFromTheMovieDbToActor(e))
            .toList();
    return movies;
  }

  //#endregion
}
