import 'dart:convert';

import 'package:my_collection/models/music/artists/spotify_artist_related_artists.dart';

SpotifyArtistAlbums spotifyArtistAlbumsFromJson(String str) => SpotifyArtistAlbums.fromJson(json.decode(str));

String spotifyArtistAlbumsToJson(SpotifyArtistAlbums data) => json.encode(data.toJson());

class SpotifyArtistAlbums {
  String? href;
  List<Item> items;
  int? limit;
  String? next;
  int? offset;
  dynamic previous;
  int? total;

  SpotifyArtistAlbums({
    this.href,
    required this.items,
    this.limit,
    this.next,
    this.offset,
    this.previous,
    this.total,
  });

  factory SpotifyArtistAlbums.fromJson(Map<String, dynamic> json) => SpotifyArtistAlbums(
    href: json["href"],
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    limit: json["limit"],
    next: json["next"],
    offset: json["offset"],
    previous: json["previous"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "limit": limit,
    "next": next,
    "offset": offset,
    "previous": previous,
    "total": total,
  };
}

class Item {
  String? albumGroup;
  String? albumType;
  List<Artist>? artists;
  List<String>? availableMarkets;
  ExternalUrls? externalUrls;
  String? href;
  String? id;
  List<Image> images;
  String? name;
  String? releaseDate;
  String? releaseDatePrecision;
  int? totalTracks;
  String? type;
  String? uri;

  Item({
    this.albumGroup,
    this.albumType,
    this.artists,
    this.externalUrls,
    this.href,
    this.id,
    required this.images,
    this.name,
    this.releaseDate,
    this.releaseDatePrecision,
    this.totalTracks,
    this.type,
    this.uri,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    albumGroup: json["album_group"],
    albumType: json["album_type"],
    artists: json["artists"] == null ? [] : List<Artist>.from(json["artists"]!.map((x) => Artist.fromJson(x))),
    externalUrls: json["external_urls"] == null ? null : ExternalUrls.fromJson(json["external_urls"]),
    href: json["href"],
    id: json["id"],
    images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
    name: json["name"],
    releaseDate: json["release_date"],
    releaseDatePrecision: json["release_date_precision"],
    totalTracks: json["total_tracks"],
    type: json["type"],
    uri: json["uri"],
  );

  Map<String, dynamic> toJson() => {
    "album_group": albumGroup,
    "album_type": albumType,
    "artists": artists == null ? [] : List<dynamic>.from(artists!.map((x) => x.toJson())),
    "external_urls": externalUrls?.toJson(),
    "href": href,
    "id": id,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
    "name": name,
    "release_date": releaseDate,
    "release_date_precision": releaseDatePrecision,
    "total_tracks": totalTracks,
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
