import 'package:dartz/dartz.dart';
import 'package:my_collection/data/network/api_endpoints.dart';
import 'package:my_collection/data/network/network.dart';
import 'package:my_collection/models/tv/tmdb_tv_response_model.dart';

class SeriesRepository{
  Future<Either<String,TmdbTvResponseModel>> fetchAiringToday() async{
    TmdbTvResponseModel airingTodayModel;
    String url = "${ApiEndpoints.tmdbBaseUrl}tv/airing_today";
    String token = ApiEndpoints.tmdbToken;

    try {
      var res = await ApiHelper().request(url: url, headers: {
        "Authorization": "Bearer $token"
      }, method: HTTPMETHOD.GET);
      if (res.statusCode == 200) {
        airingTodayModel = TmdbTvResponseModel.fromJson(res.data);
        return right(airingTodayModel);
      }
      else {
        return left(res.message);
      }
    }
    catch(e){
      return left(e.toString());
    }
  }

  Future<Either<String,TmdbTvResponseModel>> fetchOnTheAir() async{
    TmdbTvResponseModel onTheAirModel;
    String url = "${ApiEndpoints.tmdbBaseUrl}tv/on_the_air";
    String token = ApiEndpoints.tmdbToken;
    try {
      var res = await ApiHelper().request(url: url, headers: {
        "Authorization": "Bearer $token"
      }, method: HTTPMETHOD.GET);
      if (res.statusCode == 200) {
        onTheAirModel = TmdbTvResponseModel.fromJson(res.data);
        return right(onTheAirModel);
      }
      else {
        return left(res.message);
      }
    }
    catch(e){
      return left(e.toString());
    }
  }

  Future<Either<String,TmdbTvResponseModel>> fetchPopular()async{
    TmdbTvResponseModel popularModel;
    String url = "${ApiEndpoints.tmdbBaseUrl}tv/popular";
    String token = ApiEndpoints.tmdbToken;
    try {
      var res = await ApiHelper().request(url: url, headers: {
        "Authorization": "Bearer $token"
      }, method: HTTPMETHOD.GET);
      if (res.statusCode == 200) {
        popularModel = TmdbTvResponseModel.fromJson(res.data);
        return right(popularModel);
      }
      else {
        return left(res.message);
      }
    }
    catch(e){
      return left(e.toString());
    }
  }

  Future<Either<String,TmdbTvResponseModel>> fetchTopRatedSeries()async{
    TmdbTvResponseModel topRatedModel;
    String url = "${ApiEndpoints.tmdbBaseUrl}tv/top_rated";
    String token = ApiEndpoints.tmdbToken;
    try {
      var res = await ApiHelper().request(url: url, headers: {
        "Authorization": "Bearer $token"
      }, method: HTTPMETHOD.GET);
      if (res.statusCode == 200) {
        topRatedModel = TmdbTvResponseModel.fromJson(res.data);
        return right(topRatedModel);
      }
      else {
        return left(res.message);
      }
    }
    catch(e){
      return left(e.toString());
    }
  }

  Future<Either<String,TmdbTvResponseModel>> getTvSearchResults(String query)async{
    TmdbTvResponseModel topRatedModel;
    String token = ApiEndpoints.tmdbApiKey;
    String url = "${ApiEndpoints.tmdbBaseUrl}search/tv?query=$query&api_key=$token";

    try {
      var res = await ApiHelper().request(url: url, headers: {}, method: HTTPMETHOD.GET);
      if (res.statusCode == 200) {
        topRatedModel = TmdbTvResponseModel.fromJson(res.data);
        return right(topRatedModel);
      }
      else {
        return left(res.message);
      }
    }
    catch(e){
      return left(e.toString());
    }
  }

}