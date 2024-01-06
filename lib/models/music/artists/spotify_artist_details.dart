import 'dart:convert';

SpotifyArtistDetails spotifyArtistDetailsFromJson(String str) => SpotifyArtistDetails.fromJson(json.decode(str));

String spotifyArtistDetailsToJson(SpotifyArtistDetails data) => json.encode(data.toJson());

class SpotifyArtistDetails {
  ExternalUrls? externalUrls;
  Followers? followers;
  List<String> genres;
  String? href;
  String? id;
  List<Image> images;
  String? name;
  int? popularity;
  String? type;
  String? uri;

  SpotifyArtistDetails({
    this.externalUrls,
    this.followers,
    required this.genres,
    this.href,
    this.id,
    required this.images,
    this.name,
    this.popularity,
    this.type,
    this.uri,
  });

  factory SpotifyArtistDetails.fromJson(Map<String, dynamic> json) => SpotifyArtistDetails(
    externalUrls: json["external_urls"] == null ? null : ExternalUrls.fromJson(json["external_urls"]),
    followers: json["followers"] == null ? null : Followers.fromJson(json["followers"]),
    genres: json["genres"] == null ? [] : List<String>.from(json["genres"]!.map((x) => x)),
    href: json["href"],
    id: json["id"],
    images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
    name: json["name"],
    popularity: json["popularity"],
    type: json["type"],
    uri: json["uri"],
  );

  Map<String, dynamic> toJson() => {
    "external_urls": externalUrls?.toJson(),
    "followers": followers?.toJson(),
    "genres": genres == null ? [] : List<dynamic>.from(genres!.map((x) => x)),
    "href": href,
    "id": id,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
    "name": name,
    "popularity": popularity,
    "type": type,
    "uri": uri,
  };
}

class ExternalUrls {
  String? spotify;

  ExternalUrls({
    this.spotify,
  });

  factory ExternalUrls.fromJson(Map<String, dynamic> json) => ExternalUrls(
    spotify: json["spotify"],
  );

  Map<String, dynamic> toJson() => {
    "spotify": spotify,
  };
}

class Followers {
  dynamic href;
  int? total;

  Followers({
    this.href,
    this.total,
  });

  factory Followers.fromJson(Map<String, dynamic> json) => Followers(
    href: json["href"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
    "total": total,
  };
}

class Image {
  int? height;
  String? url;
  int? width;

  Image({
    this.height,
    this.url,
    this.width,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    height: json["height"],
    url: json["url"],
    width: json["width"],
  );

  Map<String, dynamic> toJson() => {
    "height": height,
    "url": url,
    "width": width,
  };
}
