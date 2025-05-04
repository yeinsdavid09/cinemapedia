import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Entities
import '../../domain/entities/movie.dart';

//* Repository
import 'movies_repository.provider.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchMoviesProvider = StateNotifierProvider((ref) {
  final movieCallBack = ref.read(moviesRepositoryProvider).getMovieByQuery;
  return SearchMoviesNotifier(movieCallBack: movieCallBack, ref: ref);
});

typedef _MovieCallBack = Future<List<Movie>> Function({required String query});

class SearchMoviesNotifier extends StateNotifier<List<Movie>> {
  //#region ----------------------------------- Variables ---------------------------------

  _MovieCallBack movieCallBack;
  Ref ref;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  SearchMoviesNotifier({required this.movieCallBack, required this.ref})
    : super([]);

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  Future<List<Movie>> getMovieByQuery({required String query}) async {
    final movies = await movieCallBack(query: query);
    ref.read(searchQueryProvider.notifier).state = query;
    state = movies;
    return movies;
  }

  //#endregion
}
