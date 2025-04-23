import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Entities
import '../domain/movies.entity.dart';

//* Providers
import './movies_repository.provider.dart';

final movieDetailsProvider = StateNotifierProvider((ref) {
  final movieCallBack = ref.watch(moviesRepositoryProvider).getMovieById;
  return MovieDetailsNotifier(movieCallBack: movieCallBack);
});

typedef _MovieCallBack = Future<Movie> Function({required String id});

class MovieDetailsNotifier extends StateNotifier<Map<String, Movie>> {
  //#region ----------------------------------- Variables ---------------------------------

  _MovieCallBack movieCallBack;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  MovieDetailsNotifier({required this.movieCallBack}) : super({});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  Future<void> getMovieById(String id) async {
    if (state[id] != null) return;
    final movie = await movieCallBack(id: id);
    state = {...state, id: movie};
  }

  //#endregion
}
