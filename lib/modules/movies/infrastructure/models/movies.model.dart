import 'dart:convert';

//* Models
import 'movie.model.dart';

class MoviesResponse {
  //#region ----------------------------------- Variables ---------------------------------

  final Dates? dates;
  final int page;
  final List<MovieResponse> results;
  final int totalPages;
  final int totalResults;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  MoviesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
    this.dates,
  });

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  factory MoviesResponse.fromRawJson(String str) =>
      MoviesResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MoviesResponse.fromJson(Map<String, dynamic> json) => MoviesResponse(
    dates: json['dates'] != null ? Dates.fromJson(json['dates']) : null,
    page: json['page'] ?? 0,
    results:
        (json['results'] as List<dynamic>? ?? [])
            .map((x) => MovieResponse.fromJson(x as Map<String, dynamic>))
            .toList(),
    totalPages: json['total_pages'] ?? 0,
    totalResults: json['total_results'] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'dates': dates?.toJson(),
    'page': page,
    'results': List<dynamic>.from(results.map((x) => x.toJson())),
    'total_pages': totalPages,
    'total_results': totalResults,
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
    maximum: DateTime.parse(json['maximum']),
    minimum: DateTime.parse(json['minimum']),
  );

  Map<String, dynamic> toJson() => {
    'maximum':
        "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
    'minimum':
        "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
  };

  //#endregion
}
