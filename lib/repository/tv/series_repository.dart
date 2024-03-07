import 'package:dartz/dartz.dart';
import 'package:my_collection/data/network/api_endpoints.dart';
import 'package:my_collection/data/network/network.dart';
import 'package:my_collection/data/network/secrets.dart';
import 'package:my_collection/domain/i_series_repository.dart';
import 'package:my_collection/models/tv/tmdb_tv_agg_credits_response_model.dart';
import 'package:my_collection/models/tv/tmdb_tv_details_response_model.dart';
import 'package:my_collection/models/tv/tmdb_tv_response_model.dart';

class SeriesRepository extends ISeriesRepository{
  final ApiHelper apiHelper;
  SeriesRepository({required this.apiHelper});
  @override
  Future<Either<String,TmdbTvResponseModel>> fetchAiringToday() async{
    TmdbTvResponseModel airingTodayModel;
    String url = "${ApiEndpoints.tmdbBaseUrl}tv/airing_today";
    String token = Secrets.tmdbToken;

    try {
      var res = await apiHelper.request(url: url, headers: {
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

  @override
  Future<Either<String,TmdbTvResponseModel>> fetchOnTheAir() async{
    TmdbTvResponseModel onTheAirModel;
    String url = "${ApiEndpoints.tmdbBaseUrl}tv/on_the_air";
    String token = Secrets.tmdbToken;
    try {
      var res = await apiHelper.request(url: url, headers: {
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

  @override
  Future<Either<String,TmdbTvResponseModel>> fetchPopular()async{
    TmdbTvResponseModel popularModel;
    String url = "${ApiEndpoints.tmdbBaseUrl}tv/popular";
    String token = Secrets.tmdbToken;
    try {
      var res = await apiHelper.request(url: url, headers: {
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

  @override
  Future<Either<String,TmdbTvResponseModel>> fetchTopRatedSeries()async{
    TmdbTvResponseModel topRatedModel;
    String url = "${ApiEndpoints.tmdbBaseUrl}tv/top_rated";
    String token = Secrets.tmdbToken;
    try {
      var res = await apiHelper.request(url: url, headers: {
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

  @override
  Future<Either<String,TmdbTvResponseModel>> getTvSearchResults(String query)async{
    TmdbTvResponseModel topRatedModel;
    String token = Secrets.tmdbApiKey;
    String url = "${ApiEndpoints.tmdbBaseUrl}search/tv?query=$query&api_key=$token";

    try {
      var res = await apiHelper.request(url: url, headers: {}, method: HTTPMETHOD.GET);
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

  @override
  Future<Either<String,TmdbTvAggCreditsResponseModel>> getSeriesAggCredits(String seriesId) async{
    TmdbTvAggCreditsResponseModel creditsResponseModel;
    String token = Secrets.tmdbApiKey;
    String url = "${ApiEndpoints.tmdbBaseUrl}tv/$seriesId/aggregate_credits?api_key=$token";

    try {
      var res = await apiHelper.request(url: url, headers: {}, method: HTTPMETHOD.GET);
      if (res.statusCode == 200) {
        creditsResponseModel = TmdbTvAggCreditsResponseModel.fromJson(res.data);
        return right(creditsResponseModel);
      }
      else {
        return left(res.message);
      }
    }
    catch(e){
      return left(e.toString());
    }
  }

  @override
  Future<Either<String,TmdbTvDetailsResponseModel>> getSeriesDetails(String seriesId) async{
    TmdbTvDetailsResponseModel responseModel;
    String token = Secrets.tmdbApiKey;
    String url = "${ApiEndpoints.tmdbBaseUrl}tv/$seriesId?api_key=$token";

    try {
      var res = await apiHelper.request(url: url, headers: {}, method: HTTPMETHOD.GET);
      if (res.statusCode == 200) {
        responseModel = TmdbTvDetailsResponseModel.fromJson(res.data);
        return right(responseModel);
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