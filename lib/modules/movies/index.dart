//#region ----------------------------------- Domain ---------------------------------

export './domain/movies.datasource.dart';
export './domain/movies.entity.dart';
export './domain/movies.repository.dart';
export './domain/movies.repository-impl.dart';

//#endregion

//#region ----------------------------------- Datasources ---------------------------------

export 'datasources/the_movie_db/models/movie.model.dart';
export 'datasources/the_movie_db/models/movies.model.dart';
export 'datasources/the_movie_db/models/details.model.dart';
export './datasources/the_movie_db/infrastructure/themoviedb.datasource.dart';

//#endregion

//#region ----------------------------------- Mappers ---------------------------------

export './mappers/movies.mapper.dart';

//#endregion

//#region ----------------------------------- Providers ---------------------------------

export './providers/movies.provider.dart';
export './providers/movies_repository.provider.dart';
export './providers/movies_slider.provider.dart';
export './providers/movies_search.provider.dart';

//#endregion

//#region ----------------------------------- Presentation ---------------------------------

export 'presentation/screens/movie.screen.dart';

export 'presentation/widgets/movies_slider.widget.dart';
export 'presentation/widgets/movies_horizontal_list.widget.dart';

export './presentation/delegates/movies_search.delegate.dart';

//#endregion
