import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:my_collection/data/network/api_endpoints.dart';
import 'package:my_collection/data/network/network.dart';
import 'package:my_collection/domain/i_music_repository.dart';
import 'package:my_collection/models/music/artists/spotify_artist_albums.dart';
import 'package:my_collection/models/music/artists/spotify_artist_details.dart';
import 'package:my_collection/models/music/artists/spotify_artist_related_artists.dart';
import 'package:my_collection/models/music/artists/spotify_artist_top_tracks.dart';
import 'package:my_collection/models/music/spotify_search_response_model.dart';

class MusicRepository implements IMusicRepository{
  final ApiHelper apiHelper;
  MusicRepository({required this.apiHelper});
  @override
  Future<Either<String, String>> getSpotifyToken() async {
    try {
      var res = await apiHelper.request(
          url: ApiEndpoints.spotifyGenerateToken,
          method: HTTPMETHOD.POST,
          headers: {
            "Content-Type": "application/x-www-form-urlencoded"
          },
          data: {
            "grant_type": "client_credentials",
            "client_id": ApiEndpoints.spotifyClientId,
            "client_secret": ApiEndpoints.spotifyClientSecret
          });
      if (res.statusCode == 200) {
        String token = res.data["access_token"];
        return right(token);
      } else {
        return left(res.message);
      }
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, SpotifySearchResponseModel>> getSpotifySearchResults(
      String accessToken, String query, String queryType,
      {int offset = 0, int limit = 20}) async {
    SpotifySearchResponseModel spotifySearchResponseModel;
    // String url =
    //     "${ApiEndpoints.spotifyBaseUrl}search?q=$query&type=$queryType&offset=$offset&limit=$limit";
    String url =
        "${ApiEndpoints.spotifyBaseUrl}search?q=$query&type=$queryType";
    try {
      var res =
          await apiHelper.request(url: url, method: HTTPMETHOD.GET, headers: {
        "Authorization": "Bearer $accessToken",
      });
      if (res.statusCode == 200) {
        spotifySearchResponseModel =
            SpotifySearchResponseModel.fromJson(res.data);
        return right(spotifySearchResponseModel);
      } else {
        return left(res.message);
      }
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, SpotifyArtistDetails>> getSpotifyArtistDetails(
      String artistId, String accessToken) async {
    SpotifyArtistDetails spotifyArtistDetails;
    String url = "${ApiEndpoints.spotifyArtistDetails}$artistId";
    try {
      var res =
          await apiHelper.request(url: url, method: HTTPMETHOD.GET, headers: {
        "Authorization": "Bearer $accessToken",
      });
      if (res.statusCode == 200) {
        spotifyArtistDetails = SpotifyArtistDetails.fromJson(res.data);
        return right(spotifyArtistDetails);
      } else {
        return left(res.message);
      }
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, SpotifyArtistAlbums>> getSpotifyArtistAlbums(
      String artistId, String accessToken) async {
    SpotifyArtistAlbums spotifyArtistAlbums;
    String url = "${ApiEndpoints.spotifyArtistDetails}$artistId/albums";
    try {
      var res =
          await apiHelper.request(url: url, method: HTTPMETHOD.GET, headers: {
        "Authorization": "Bearer $accessToken",
      });
      if (res.statusCode == 200) {
        spotifyArtistAlbums = SpotifyArtistAlbums.fromJson(res.data);
        return right(spotifyArtistAlbums);
      } else {
        return left(res.message);
      }
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, SpotifyArtistTopTracks>> getSpotifyArtistTopTracks(
      String artistId, String accessToken) async {
    SpotifyArtistTopTracks spotifyArtistTopTracks;
    String url = "${ApiEndpoints.spotifyArtistDetails}$artistId/top-tracks?market=IN";
    try {
      var res =
          await apiHelper.request(url: url, method: HTTPMETHOD.GET, headers: {
        "Authorization": "Bearer $accessToken",
      });
      if (res.statusCode == 200) {
        spotifyArtistTopTracks = SpotifyArtistTopTracks.fromJson(res.data);
        return right(spotifyArtistTopTracks);
      } else {
        return left(res.message);
      }
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, SpotifyArtistRelatedArtists>> getSpotifyArtistRelatedArtists(
      String artistId, String accessToken) async {
    SpotifyArtistRelatedArtists spotifyArtistRelatedArtists;
    String url = "${ApiEndpoints.spotifyArtistDetails}$artistId/related-artists";
    try {
      var res =
      await apiHelper.request(url: url, method: HTTPMETHOD.GET, headers: {
        "Authorization": "Bearer $accessToken",
      });
      if (res.statusCode == 200) {
        spotifyArtistRelatedArtists = SpotifyArtistRelatedArtists.fromJson(res.data);
        return right(spotifyArtistRelatedArtists);
      } else {
        return left(res.message);
      }
    } catch (e) {
      return left(e.toString());
    }
  }
}
