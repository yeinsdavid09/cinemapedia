//* Entities
import '../domain/movies.entity.dart';

//* Models
import '../datasources/the_movie_db/models/movie.model.dart';
import '../datasources/the_movie_db/models/details.model.dart';

class MoviesMapper {
  //#region --------------------------------- Methods ---------------------------------

  static Movie movieFromTheMovieDbToMovie(MovieResponse movie) {
    return Movie(
      adult: movie.adult,
      backdropPath:
          movie.backdropPath != ''
              ? 'https://image.tmdb.org/t/p/w500/${movie.backdropPath}'
              : 'https://upload.wikimedia.org/wikipedia/commons/a/a3/Image-not-found.png',
      genreIds:
          movie.genreIds != null
              ? movie.genreIds!.map((e) => e.toString()).toList()
              : [''],
      id: movie.id,
      originalLanguage: movie.originalLanguage,
      originalTitle: movie.originalTitle,
      overview: movie.overview ?? '',
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

  static Movie detailsFromTheMovieDbToMovie(DetailsResponse movie) {
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
      overview: movie.overview ?? '',
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
