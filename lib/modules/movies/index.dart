//#region ----------------------------------- Domain ---------------------------------

export './domain/datasources/movies.datasource.dart';
export './domain/entities/movie.dart';
export './domain/repositories/movies.repository.dart';
export './domain/repositories/movies.repository-impl.dart';

export './domain/datasources/local_storage.datasource.dart';
export './domain/repositories/local_storage.repository.dart';
export './domain/repositories/local_storage.repository-impl.dart';

//#endregion

//#region ----------------------------------- Datasources ---------------------------------

export './datasources/the_movie_db/models/movie.model.dart';
export './datasources/the_movie_db/models/movies.model.dart';
export './datasources/the_movie_db/models/details.model.dart';
export './datasources/the_movie_db/infrastructure/themoviedb.datasource.dart';
export './datasources/isar/infrastructure/isar.datasource.dart';

//#endregion

//#region ----------------------------------- Mappers ---------------------------------

export './mappers/movies.mapper.dart';

//#endregion

//#region ----------------------------------- Providers ---------------------------------

export './providers/movies.provider.dart';
export './providers/movies_repository.provider.dart';
export './providers/movies_slider.provider.dart';
export './providers/movies_search.provider.dart';
export './providers/movie_details.providers.dart';

export './providers/local_storage_repository.provider.dart';
export './providers/is_favorite.provider.dart';
export './providers/favorites_movies.provider.dart';

//#endregion

//#region ----------------------------------- Presentation ---------------------------------

export './presentation/screens/movie.screen.dart';

export './presentation/widgets/movies_slider.widget.dart';
export './presentation/widgets/movies_horizontal_list.widget.dart';
export './presentation/widgets/movies_masonry.widget.dart';

export './presentation/delegates/movies_search.delegate.dart';

//#endregion
