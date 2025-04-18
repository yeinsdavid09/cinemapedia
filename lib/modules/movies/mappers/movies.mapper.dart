//* Entities
import 'package:cinemapedia/modules/movies/domain/movies.entity.dart';

//* Models
import 'package:cinemapedia/modules/movies/models/the_movie_db/movie_from_themoviedb.model.dart';

class MoviesMapper {
  //#region --------------------------------- Methods ---------------------------------

  static Movie movieFromTheMovieDbToMovie(MovieFromTheMovieDB movie) {
    return Movie(
      adult: movie.adult,
      backdropPath:
          movie.backdropPath != ''
              ? 'https://image.tmdb.org/t/p/w500/${movie.backdropPath}'
              : 'https://upload.wikimedia.org/wikipedia/commons/a/a3/Image-not-found.png',
      genreIds: movie.genreIds.map((e) => e.toString()).toList(),
      id: movie.id,
      originalLanguage: movie.originalLanguage,
      originalTitle: movie.originalTitle,
      overview: movie.overview,
      popularity: movie.popularity,
      posterPath:
          movie.posterPath != ''
              ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
              : 'not-found',
      releaseDate: movie.releaseDate,
      title: movie.title,
      video: movie.video,
      voteAverage: movie.voteAverage,
      voteCount: movie.voteCount,
    );
  }

  //#endregion
}
