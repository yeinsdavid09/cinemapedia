//* Entities
import './actors.entity.dart';

abstract class ActorsRepository {
  //#region --------------------------------- Methods ---------------------------------

  Future<List<Actor>> getActorsByMovieId({required String id});

  //#endregion
}
