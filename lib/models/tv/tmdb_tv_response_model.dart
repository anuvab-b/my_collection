import 'dart:convert';

import 'package:my_collection/utils/date_utils.dart';

TmdbTvResponseModel tmdbTvResponseModelFromJson(String str) => TmdbTvResponseModel.fromJson(json.decode(str));

String tmdbTvResponseModelToJson(TmdbTvResponseModel data) => json.encode(data.toJson());

class TmdbTvResponseModel {
  int? page;
  List<SeriesListModel> results;
  int? totalPages;
  int? totalResults;
  String? name;
  String? uuid;

  TmdbTvResponseModel({
    this.page,
    required this.results,
    this.totalPages,
    this.totalResults,
    this.name,
    this.uuid
  });

  factory TmdbTvResponseModel.fromJson(Map<String, dynamic> json) => TmdbTvResponseModel(
    page: json["page"],
    results: json["results"] == null ? [] : List<SeriesListModel>.from(json["results"]!.map((x) => SeriesListModel.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
    name: json["name"] ?? "",
      uuid: json["uuid"] ?? ""
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "name": name,
    "uuid": uuid
  };

  TmdbTvResponseModel copyWith(
      {String? name, String? uuid, List<SeriesListModel>? results}) {
    return TmdbTvResponseModel(
        name: name ?? this.name,
        results: results ?? this.results,
        uuid: uuid ?? this.uuid
    );
  }
}

class SeriesListModel {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  DateTime? firstAirDate;
  String? name;
  double? voteAverage;
  int? voteCount;

  SeriesListModel({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.firstAirDate,
    this.name,
    this.voteAverage,
    this.voteCount,
  });

  factory SeriesListModel.fromJson(Map<String, dynamic> json) => SeriesListModel(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    genreIds: json["genre_ids"] == null ? [] : List<int>.from(json["genre_ids"]!.map((x) => x)),
    id: json["id"],
    originCountry: json["origin_country"] == null ? [] : List<String>.from(json["origin_country"]!.map((x) => x)),
    originalLanguage: json["original_language"],
    originalName: json["original_name"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"],
    firstAirDate: json["first_air_date"] == null ? null : DateUtils.getDateTime(json["first_air_date"]),
    name: json["name"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
    "id": id,
    "origin_country": originCountry == null ? [] : List<dynamic>.from(originCountry!.map((x) => x)),
    "original_language": originalLanguage,
    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "first_air_date": "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
    "name": name,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
