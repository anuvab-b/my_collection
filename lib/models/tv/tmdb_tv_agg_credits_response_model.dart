import 'dart:convert';

TmdbTvAggCreditsResponseModel tmdbTvAggCreditsResponseModelFromJson(String str) => TmdbTvAggCreditsResponseModel.fromJson(json.decode(str));

String tmdbTvAggCreditsResponseModelToJson(TmdbTvAggCreditsResponseModel data) => json.encode(data.toJson());

class TmdbTvAggCreditsResponseModel {
  List<Cast> cast;
  List<Cast> crew;
  int? id;

  TmdbTvAggCreditsResponseModel({
    this.cast = const[],
    this.crew = const[],
    this.id,
  });

  factory TmdbTvAggCreditsResponseModel.fromJson(Map<String, dynamic> json) => TmdbTvAggCreditsResponseModel(
    cast: json["cast"] == null ? [] : List<Cast>.from(json["cast"]!.map((x) => Cast.fromJson(x))),
    crew: json["crew"] == null ? [] : List<Cast>.from(json["crew"]!.map((x) => Cast.fromJson(x))),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
    "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
    "id": id,
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
  List<Role>? roles;
  int? totalEpisodeCount;
  int? order;
  List<Job>? jobs;
  String? department;

  Cast({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.roles,
    this.totalEpisodeCount,
    this.order,
    this.jobs,
    this.department,
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
    roles: json["roles"] == null ? [] : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
    totalEpisodeCount: json["total_episode_count"],
    order: json["order"],
    jobs: json["jobs"] == null ? [] : List<Job>.from(json["jobs"]!.map((x) => Job.fromJson(x))),
    department: json["department"]
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
    "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x.toJson())),
    "total_episode_count": totalEpisodeCount,
    "order": order,
    "jobs": jobs == null ? [] : List<dynamic>.from(jobs!.map((x) => x.toJson())),
    "department": department,
  };
}

class Job {
  String? creditId;
  String? job;
  int? episodeCount;

  Job({
    this.creditId,
    this.job,
    this.episodeCount,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
    creditId: json["credit_id"],
    job: json["job"],
    episodeCount: json["episode_count"],
  );

  Map<String, dynamic> toJson() => {
    "credit_id": creditId,
    "job": job,
    "episode_count": episodeCount,
  };
}

class Role {
  String? creditId;
  String? character;
  int? episodeCount;

  Role({
    this.creditId,
    this.character,
    this.episodeCount,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    creditId: json["credit_id"],
    character: json["character"],
    episodeCount: json["episode_count"],
  );

  Map<String, dynamic> toJson() => {
    "credit_id": creditId,
    "character": character,
    "episode_count": episodeCount,
  };
}
