import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Repository
import '../implementations/favorites.repository-impl.dart';

//* Datasources
import '../implementations/favorites.datasource-impl.dart';

final favoritesRepositoryProvider = Provider((ref) {
  return FavoritesRepositoryImpl(datasource: FavoritesDatasourceImpl());
});
