//* Entities
import './actors.entity.dart';

abstract class ActorsDatasource {
  //#region --------------------------------- Methods ---------------------------------

  Future<List<Actor>> getActorsByMovieId({required String id});

  //#endregion
}
