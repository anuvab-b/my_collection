import 'dart:convert';

TmdbMovieCreditsResponseModel tmdbMovieCreditsResponseModelFromJson(String str) => TmdbMovieCreditsResponseModel.fromJson(json.decode(str));

String tmdbMovieCreditsResponseModelToJson(TmdbMovieCreditsResponseModel data) => json.encode(data.toJson());

class TmdbMovieCreditsResponseModel {
  int? id;
  List<Cast> cast;
  List<Cast> crew;

  TmdbMovieCreditsResponseModel({
    this.id,
    this.cast = const [],
    this.crew = const []
  });

  factory TmdbMovieCreditsResponseModel.fromJson(Map<String, dynamic> json) => TmdbMovieCreditsResponseModel(
    id: json["id"],
    cast: json["cast"] == null ? [] : List<Cast>.from(json["cast"]!.map((x) => Cast.fromJson(x))),
    crew: json["crew"] == null ? [] : List<Cast>.from(json["crew"]!.map((x) => Cast.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
    "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
  };
}

class Cast {
  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  int? castId;
  String? character;
  String? creditId;
  int? order;
  String? department;
  String? job;

  Cast({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
    adult: json["adult"],
    gender: json["gender"],
    id: json["id"],
    knownForDepartment: json["known_for_department"],
    name: json["name"],
    originalName: json["original_name"],
    popularity: json["popularity"]?.toDouble(),
    profilePath: json["profile_path"],
    castId: json["cast_id"],
    character: json["character"],
    creditId: json["credit_id"],
    order: json["order"],
    department: json["department"],
    job: json["job"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "gender": gender,
    "id": id,
    "known_for_department": knownForDepartment,
    "name": name,
    "original_name": originalName,
    "popularity": popularity,
    "profile_path": profilePath,
    "cast_id": castId,
    "character": character,
    "credit_id": creditId,
    "order": order,
    "department": department,
    "job": job,
  };
}