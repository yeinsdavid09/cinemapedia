import 'dart:convert';

//* Models
import 'package:cinemapedia/modules/movies/models/the_movie_db/movie_from_themoviedb.model.dart';

class TheMovieDBResponse {
  //#region ----------------------------------- Variables ---------------------------------

  final Dates? dates;
  final int page;
  final List<MovieFromTheMovieDB> results;
  final int totalPages;
  final int totalResults;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  TheMovieDBResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
    this.dates,
  });

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  factory TheMovieDBResponse.fromRawJson(String str) =>
      TheMovieDBResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TheMovieDBResponse.fromJson(Map<String, dynamic> json) =>
      TheMovieDBResponse(
        dates: json["dates"] != null ? Dates.fromJson(json["dates"]) : null,
        page: json["page"],
        results: List<MovieFromTheMovieDB>.from(
          json["results"].map((x) => MovieFromTheMovieDB.fromJson(x)),
        ),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
    "dates": dates?.toJson(),
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };

  //#endregion
}

class Dates {
  //#region ----------------------------------- Variables ---------------------------------

  final DateTime maximum;
  final DateTime minimum;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  Dates({required this.maximum, required this.minimum});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  factory Dates.fromRawJson(String str) => Dates.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
    maximum: DateTime.parse(json["maximum"]),
    minimum: DateTime.parse(json["minimum"]),
  );

  Map<String, dynamic> toJson() => {
    "maximum":
        "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
    "minimum":
        "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
  };

  //#endregion
}
