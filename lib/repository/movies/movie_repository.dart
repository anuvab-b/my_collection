import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_collection/data/network/api_endpoints.dart';
import 'package:my_collection/data/network/network.dart';
import 'package:my_collection/models/movies/tmdb_movie_response_model.dart';

class MovieRepository extends ChangeNotifier{

  Future<Either<String,TmdbMovieResponseModel>> fetchNowPlayingMovies() async{
    TmdbMovieResponseModel nowPlayingModel;
    String url = "${ApiEndpoints.tmdbBaseUrl}movie/now_playing";
    String token = ApiEndpoints.tmdbToken;

    try {
      var res = await ApiHelper().request(url: url, headers: {
        "Authorization": "Bearer $token"
      }, method: HTTPMETHOD.GET);
      if (res.statusCode == 200) {
        nowPlayingModel = TmdbMovieResponseModel.fromJson(res.data);
        return right(nowPlayingModel);
      }
      else {
        return left(res.message ?? "");
      }
    }
    catch(e){
      return left(e.toString());
    }
  }

  Future<Either<String,TmdbMovieResponseModel>> fetchPopularMovies() async{
    TmdbMovieResponseModel upcomingModel;
    String url = "${ApiEndpoints.tmdbBaseUrl}movie/popular";
    String token = ApiEndpoints.tmdbToken;
    try {
      var res = await ApiHelper().request(url: url, headers: {
        "Authorization": "Bearer $token"
      }, method: HTTPMETHOD.GET);
      if (res.statusCode == 200) {
        upcomingModel = TmdbMovieResponseModel.fromJson(res.data);
        return right(upcomingModel);
      }
      else {
        return left(res.message ?? "");
      }
    }
    catch(e){
      return left(e.toString());
    }
  }

  Future<Either<String,TmdbMovieResponseModel>> fetchUpcomingMovies()async{
    TmdbMovieResponseModel upcomingModel;
    String url = "${ApiEndpoints.tmdbBaseUrl}movie/top_rated";
    String token = ApiEndpoints.tmdbToken;
    try {
      var res = await ApiHelper().request(url: url, headers: {
        "Authorization": "Bearer $token"
      }, method: HTTPMETHOD.GET);
      if (res.statusCode == 200) {
        upcomingModel = TmdbMovieResponseModel.fromJson(res.data);
        return right(upcomingModel);
      }
      else {
        return left(res.message ?? "");
      }
    }
    catch(e){
      return left(e.toString());
    }
  }

  Future<Either<String,TmdbMovieResponseModel>> fetchTopRatedMovies()async{
    TmdbMovieResponseModel topRatedModel;
    String url = "${ApiEndpoints.tmdbBaseUrl}movie/upcoming";
    String token = ApiEndpoints.tmdbToken;
    try {
      var res = await ApiHelper().request(url: url, headers: {
        "Authorization": "Bearer $token"
      }, method: HTTPMETHOD.GET);
      if (res.statusCode == 200) {
        topRatedModel = TmdbMovieResponseModel.fromJson(res.data);
        return right(topRatedModel);
      }
      else {
        return left(res.message ?? "");
      }
    }
    catch(e){
      return left(e.toString());
    }
  }

}