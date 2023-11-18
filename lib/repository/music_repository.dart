import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:my_collection/data/network/api_endpoints.dart';
import 'package:my_collection/data/network/network.dart';
import 'package:my_collection/models/music/spotify_search_response_model.dart';

class MusicRepository {
  Future<Either<String, String>> getSpotifyToken() async {
    try {
      var res = await ApiHelper().request(
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
        return left(res.message ?? "");
      }
    } catch (e) {
      return left(e.toString());
    }
  }

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
          await ApiHelper().request(url: url, method: HTTPMETHOD.GET, headers: {
        "Authorization": "Bearer $accessToken",
      });
      if (res.statusCode == 200) {
        spotifySearchResponseModel =
            SpotifySearchResponseModel.fromJson(res.data);
        return right(spotifySearchResponseModel);
      } else {
        return left(res.message ?? "");
      }
    } catch (e) {
      return left(e.toString());
    }
  }
}
