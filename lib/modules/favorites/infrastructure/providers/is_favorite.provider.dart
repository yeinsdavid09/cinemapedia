import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Providers
import 'favorites_repository.provider.dart';

final isFavoriteProvider = FutureProvider.family.autoDispose((
  ref,
  int movieId,
) {
  final localStorageProvider = ref.watch(favoritesRepositoryProvider);
  return localStorageProvider.isFavorite(movieId: movieId);
});
