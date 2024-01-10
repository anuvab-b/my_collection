import 'package:my_collection/models/music/spotify_search_response_model.dart';

class PlayListModel {
  final String name;
  final String uuid;
  final List<PlayListItem> items;

  PlayListModel({required this.items, required this.name, required this.uuid});

  factory PlayListModel.fromJson(Map<String, dynamic> json) => PlayListModel(
      name: json["name"] ?? "",
      uuid: json["uuid"] ?? "",
      items: json["items"] == null
          ? []
          : List<PlayListItem>.from(
              json["items"]!.map((x) => PlayListItem.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "name": name,
        "uuid": uuid,
        "items": items.isEmpty
            ? []
            : List<dynamic>.from(items.map((x) => x.toJson()))
      };

  PlayListModel copyWith(
      {String? name, String? uuid, List<PlayListItem>? items}) {
    return PlayListModel(
      name: name ?? this.name,
      items: items ?? this.items,
      uuid: uuid ?? this.uuid,
    );
  }
}

class PlayListItem {
  final String name;
  final AlbumElement? album;
  final List<Owner>? artists;

  PlayListItem(
      {required this.name, required this.artists, required this.album});

  factory PlayListItem.fromJson(Map<String, dynamic> json) => PlayListItem(
      name: json["name"] ?? "",
      album:
          json["album"] == null ? null : AlbumElement.fromJson(json["album"]),
      artists: json["artists"] == null
          ? []
          : List<Owner>.from(json["artists"]!.map((x) => Owner.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "name": name,
        "album": album?.toJson(),
        "artists": artists == null
            ? []
            : List<dynamic>.from(artists!.map((x) => x.toJson()))
      };
}
