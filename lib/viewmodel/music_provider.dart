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
  MusicProvider() {
    textEditingController = TextEditingController();
  }

  MusicRepository musicRepository = MusicRepository();

  bool isSearchLoading = false;
  late TextEditingController textEditingController;
  late SpotifySearchResponseModel spotifySearchResponseModel;
  MusicSearchCategories selectedFilterCategory = MusicSearchCategories.track;
  Map<String,Either<String, SpotifySearchResponseModel>?> musicSearchMap = {};

  Future<Either<String, SpotifySearchResponseModel>?> getMusicBySearch(String query, String filterType) async {
    if(musicSearchMap.containsKey(query)) {
      return musicSearchMap[query];
    }
    else {
      var result = await musicRepository.getSpotifySearchResults(
          query, "album,track,artist,playlist");
      if(query.isNotEmpty) {
        musicSearchMap.putIfAbsent(query, () => result);
      }
      result.fold((l) {}, (r) {
        spotifySearchResponseModel = r;
      });
      return result;
    }
  }

  void onFilterCategoryChanged(MusicSearchCategories newCategory){
    selectedFilterCategory = newCategory;
    notifyListeners();
  }

  Future<void> getToken() async{
    var result = await musicRepository.getSpotifyToken();
  }
}
