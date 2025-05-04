import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Providers
import './local_storage_repository.provider.dart';

final isFavoriteProvider = FutureProvider.family.autoDispose((
  ref,
  int movieId,
) {
  final localStorageProvider = ref.watch(localStorageRepositoryProvider);
  return localStorageProvider.isFavorite(movieId: movieId);
});
