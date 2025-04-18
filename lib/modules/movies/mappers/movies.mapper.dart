//* Entities
import '../domain/movies.entity.dart';

//* Models
import '../models/the_movie_db/movie_from_themoviedb.model.dart';
import '../models/the_movie_db/movie_details.model.dart';

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

  static Movie movieFromMovieDetailsToMovie(TheMovieDBDetails movie) {
    return Movie(
      adult: movie.adult,
      backdropPath:
          movie.backdropPath != ''
              ? 'https://image.tmdb.org/t/p/w500/${movie.backdropPath}'
              : 'https://upload.wikimedia.org/wikipedia/commons/a/a3/Image-not-found.png',
      genreIds: movie.genres.map((e) => e.name.toString()).toList(),
      id: movie.id,
      originalLanguage: movie.originalLanguage,
      originalTitle: movie.originalTitle,
      overview: movie.overview,
      popularity: movie.popularity,
      posterPath:
          movie.posterPath != ''
              ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
              : 'https://upload.wikimedia.org/wikipedia/commons/a/a3/Image-not-found.png',
      releaseDate: movie.releaseDate,
      title: movie.title,
      video: movie.video,
      voteAverage: movie.voteAverage,
      voteCount: movie.voteCount,
    );
  }

  //#endregion
}
