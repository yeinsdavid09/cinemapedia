//* Entities
import '../domain/actors.entity.dart';

//* Models
import '../datasources/the_movie_db/models/credits.model.dart';

class ActorsMapper {
  //#region --------------------------------- Methods ---------------------------------

  static Actor castFromTheMovieDbToActor(Cast cast) {
    return Actor(
      id: cast.id,
      name: cast.name,
      profilePath:
          cast.profilePath != ''
              ? 'https://image.tmdb.org/t/p/w500/${cast.profilePath}'
              : 'https://upload.wikimedia.org/wikipedia/commons/a/a3/Image-not-found.png',
      character: cast.character,
    );
  }

  //#endregion
}
