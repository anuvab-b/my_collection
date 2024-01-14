import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_collection/models/music/artists/spotify_artist_albums.dart';
import 'package:my_collection/models/music/artists/spotify_artist_details.dart';
import 'package:my_collection/models/music/artists/spotify_artist_related_artists.dart';
import 'package:my_collection/models/music/artists/spotify_artist_top_tracks.dart';
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
  bool isArtistDetailsLoading = false;
  bool isArtistAlbumsLoading = false;
  bool isArtistTopTracksLoading = false;
  bool isArtistRelatedArtistsLoading = false;
  String artistDetailsErrorMessage = "";
  String artistAlbumsErrorMessage = "";
  String artistTopTracksErrorMessage = "";
  String artistRelatedArtistsErrorMessage = "";
  late TextEditingController textEditingController;
  late SpotifySearchResponseModel? spotifySearchResponseModel;
  late SpotifyArtistDetails? spotifyArtistDetails;
  late SpotifyArtistAlbums? spotifyArtistAlbums;
  late SpotifyArtistTopTracks? spotifyArtistTopTracks;
  late SpotifyArtistRelatedArtists? spotifyArtistRelatedArtists;
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

  void onSearchQueryChanged(String query){
    searchQuery = query;
    notifyListeners();
  }

  Future<void> getToken() async {
    var result = await musicRepository.getSpotifyToken();
    result.fold((l) {}, (r) {
      accessToken = r;
    });
  }

  Future<void> getArtistDetails(String artistId) async{
    isArtistDetailsLoading = true;
    notifyListeners();
    var result = await musicRepository.getSpotifyArtistDetails(artistId, accessToken);
    isArtistDetailsLoading = false;
    notifyListeners();
    result.fold((l) {
      artistDetailsErrorMessage = l;
    }, (r) {
      artistDetailsErrorMessage = "";
      spotifyArtistDetails = r;
    });
  }

  Future<void> getArtistAlbums(String artistId) async{
    isArtistAlbumsLoading = true;
    notifyListeners();
    var result = await musicRepository.getSpotifyArtistAlbums(artistId, accessToken);
    isArtistAlbumsLoading = false;
    notifyListeners();
    result.fold((l) {
      artistAlbumsErrorMessage = l;
    }, (r) {
      artistAlbumsErrorMessage = "";
      spotifyArtistAlbums = r;
    });
  }
  Future<void> getSpotifyArtistTopTracks(String artistId) async{
    isArtistTopTracksLoading = true;
    notifyListeners();
    var result = await musicRepository.getSpotifyArtistTopTracks(artistId, accessToken);
    isArtistTopTracksLoading = false;
    notifyListeners();
    result.fold((l) {
      artistTopTracksErrorMessage = l;
    }, (r) {
      artistTopTracksErrorMessage = "";
      spotifyArtistTopTracks = r;
    });
  }

  Future<void> getSpotifyArtistRelatedArtists(String artistId) async{
    isArtistRelatedArtistsLoading = true;
    notifyListeners();
    var result = await musicRepository.getSpotifyArtistRelatedArtists(artistId, accessToken);
    isArtistRelatedArtistsLoading = false;
    notifyListeners();
    result.fold((l) {
      artistTopTracksErrorMessage = l;
    }, (r) {
      artistTopTracksErrorMessage = "";
      spotifyArtistRelatedArtists = r;
    });
  }
}
