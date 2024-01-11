import 'dart:convert';

TmdbMovieResponseModel tmdbMovieResponseModelFromJson(String str) => TmdbMovieResponseModel.fromJson(json.decode(str));

String tmdbMovieResponseModelToJson(TmdbMovieResponseModel data) => json.encode(data.toJson());

class TmdbMovieResponseModel {
  Dates? dates;
  int? page;
  List<MovieListModel> results;
  int? totalPages;
  int? totalResults;
  String? name;
  String? uuid;

  TmdbMovieResponseModel({
    this.dates,
    this.page,
    required this.results,
    this.totalPages,
    this.totalResults,
    this.name,
    this.uuid
  });

  factory TmdbMovieResponseModel.fromJson(Map<String, dynamic> json) => TmdbMovieResponseModel(
    dates: json["dates"] == null ? null : Dates.fromJson(json["dates"]),
    page: json["page"],
    results: json["results"] == null ? [] : List<MovieListModel>.from(json["results"]!.map((x) => MovieListModel.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "uuid": uuid,
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
  };

  TmdbMovieResponseModel copyWith(
      {String? name, String? uuid, List<MovieListModel>? results}) {
    return TmdbMovieResponseModel(
      name: name ?? this.name,
      results: results ?? this.results,
      uuid: uuid ?? this.uuid
    );
  }
}

class Dates {
  DateTime? maximum;
  DateTime? minimum;

  Dates({
    this.maximum,
    this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
    maximum: json["maximum"] == null ? null : DateTime.parse(json["maximum"]),
    minimum: json["minimum"] == null ? null : DateTime.parse(json["minimum"]),
  );

  Map<String, dynamic> toJson() => {
    "maximum": "${maximum!.year.toString().padLeft(4, '0')}-${maximum!.month.toString().padLeft(2, '0')}-${maximum!.day.toString().padLeft(2, '0')}",
    "minimum": "${minimum!.year.toString().padLeft(4, '0')}-${minimum!.month.toString().padLeft(2, '0')}-${minimum!.day.toString().padLeft(2, '0')}",
  };
}

class MovieListModel {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  DateTime? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  MovieListModel({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory MovieListModel.fromJson(Map<String, dynamic> json) => MovieListModel(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    genreIds: json["genre_ids"] == null ? [] : List<int>.from(json["genre_ids"]!.map((x) => x)),
    id: json["id"],
    originalLanguage: json["original_language"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"],
    releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
    title: json["title"],
    video: json["video"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
    "id": id,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "release_date": "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}