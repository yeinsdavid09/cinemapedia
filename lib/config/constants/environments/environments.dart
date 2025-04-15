import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environments {
  //#region ----------------------------------- Variables ---------------------------------

  static String theMovieDbApi = dotenv.env['THE_MOVIE_DB_API'] ?? 'No key';
  static String theMovieDbKey = dotenv.env['THE_MOVIE_DB_KEY'] ?? 'No key';

  //#endregion
}
