import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environments {
  //#region ----------------------------------- Variables ---------------------------------

  static String theMovieDbKey = dotenv.env['THE_MOVIE_DB_KEY'] ?? 'No key';

  //#endregion
}
