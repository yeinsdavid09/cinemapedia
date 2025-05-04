import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Repository
import '../domain/repositories/local_storage.repository-impl.dart';

//* Datasources
import '../datasources/isar/infrastructure/isar.datasource.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(datasource: IsarDatasource());
});
