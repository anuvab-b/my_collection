import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_collection/models/music/spotify_search_response_model.dart';
import 'package:my_collection/repository/music_repository.dart';

enum MusicSearchCategories {
  album,
  artist,
  playlist,
  track,
  show,
  episode,
  audiobook
}

class MusicProvider extends ChangeNotifier {
  late FirebaseFirestore db;
  String searchQuery = "";
  MusicProvider() {
    db = FirebaseFirestore.instance;
    textEditingController = TextEditingController();
  }

  MusicRepository musicRepository = MusicRepository();

  bool isSearchLoading = false;
  late TextEditingController textEditingController;
  late SpotifySearchResponseModel spotifySearchResponseModel;
  MusicSearchCategories selectedFilterCategory = MusicSearchCategories.track;
  Map<String, Either<String, SpotifySearchResponseModel>?> musicSearchMap = {};

  String accessToken = "";

  Future<Either<String, SpotifySearchResponseModel>?> getMusicBySearch(
      String query, String filterType) async {
    Either<String, SpotifySearchResponseModel>? result;
    if (musicSearchMap.containsKey(query)) {
      result = musicSearchMap[query];
    } else {
      if(query.isNotEmpty) {
        result = await musicRepository.getSpotifySearchResults(
            accessToken, query, "album,track,artist,playlist");
        if (query.isNotEmpty) {
          musicSearchMap.putIfAbsent(query, () => result);
        }
        result.fold((l) {}, (r) {
          spotifySearchResponseModel = r;
        });
      }
    }
    return result;
  }

  void onFilterCategoryChanged(MusicSearchCategories newCategory) {
    selectedFilterCategory = newCategory;
    notifyListeners();
  }

  Future<void> getToken() async {
    var result = await musicRepository.getSpotifyToken();
    result.fold((l) {}, (r) {
      accessToken = r;
    });
  }
}
