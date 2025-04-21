import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Entities
import '../domain/actors.entity.dart';

//* Providers
import './actors_repository.provider.dart';

final actorsProvider = StateNotifierProvider((ref) {
  final movieCallBack = ref.watch(actorsRepositoryProvider).getActorsByMovieId;
  return ActorsNotifier(movieCallBack: movieCallBack);
});

typedef MovieCallBack = Future<List<Actor>> Function({required String id});

class ActorsNotifier extends StateNotifier<Map<String, List<Actor>>> {
  //#region ----------------------------------- Variables ---------------------------------

  bool moviesAreLoading = false;
  MovieCallBack movieCallBack;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  ActorsNotifier({required this.movieCallBack}) : super({});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  Future<void> getActorsByMovieId(String id) async {
    if (state[id] != null) return;
    final actor = await movieCallBack(id: id);
    state = {...state, id: actor};
  }

  //#endregion
}
