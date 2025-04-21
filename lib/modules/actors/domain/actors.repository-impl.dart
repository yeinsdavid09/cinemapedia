//* Repository
import './actors.repository.dart';

//* Datasource
import './actors.datasource.dart';

//* Entities
import './actors.entity.dart';

class ActorsRepositoryImpl implements ActorsRepository {
  //#region ----------------------------------- Variables ---------------------------------

  final ActorsDatasource datasource;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  ActorsRepositoryImpl({required this.datasource});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Future<List<Actor>> getActorsByMovieId({required String id}) {
    return datasource.getActorsByMovieId(id: id);
  }

  //#endregion
}
