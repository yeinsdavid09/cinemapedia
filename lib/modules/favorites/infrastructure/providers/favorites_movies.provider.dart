import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Entities
import '../../../movies/domain/entities/movie.dart';

//* Repository
import '../../domain/contracts/favorites.repository.dart';

//* Providers
import 'favorites_repository.provider.dart';

final favoritesMoviesProvider = StateNotifierProvider((ref) {
  final repository = ref.watch(favoritesRepositoryProvider);
  return FavoritesMoviesNotifier(repository: repository);
});

class FavoritesMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  //#region ----------------------------------- Variables ---------------------------------

  int currentPage = 0;
  FavoritesRepository repository;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  FavoritesMoviesNotifier({required this.repository}) : super({});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  Future<List<Movie>> loadNextPage() async {
    final List<Movie> movies = await repository.loadFavoritesMovies(
      limit: 12,
      offset: currentPage * 12,
    );
    currentPage++;
    final moviesMap = <int, Movie>{};
    for (final movie in movies) {
      moviesMap[movie.id] = movie;
    }
    state = {...state, ...moviesMap};
    return movies;
  }

  Future<void> toggleMovie({required Movie movie}) async {
    final Movie result = await repository.toggleMovie(movie: movie);
    bool isInState = state[result.id] != null;

    if (isInState) {
      state.remove(movie.id);
      state = {...state};
    } else {
      state = {...state, result.id: result};
    }
  }

  //#endregion
}
