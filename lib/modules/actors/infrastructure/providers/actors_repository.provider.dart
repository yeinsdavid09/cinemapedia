import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Repository
import '../implementations/actors.repository-impl.dart';

//* Datasources
import '../implementations/actors.datasource-impl.dart';

final actorsRepositoryProvider = Provider((ref) {
  return ActorsRepositoryImpl(datasource: ActorsDatasourceImpl());
});
