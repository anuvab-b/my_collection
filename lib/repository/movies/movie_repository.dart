import 'package:dartz/dartz.dart';
import 'package:my_collection/data/network/api_endpoints.dart';
import 'package:my_collection/data/network/network.dart';
import 'package:my_collection/models/movies/tmdb_movie_response_model.dart';

class MovieRepository{

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
        return left(res.message);
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
        return left(res.message);
      }
    }
    catch(e){
      return left(e.toString());
    }
  }

  Future<Either<String,TmdbMovieResponseModel>> fetchUpcomingMovies()async{
    TmdbMovieResponseModel upcomingModel;
    String url = "${ApiEndpoints.tmdbBaseUrl}movie/upcoming";
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
        return left(res.message);
      }
    }
    catch(e){
      return left(e.toString());
    }
  }

  Future<Either<String,TmdbMovieResponseModel>> fetchTopRatedMovies()async{
    TmdbMovieResponseModel topRatedModel;
    String url = "${ApiEndpoints.tmdbBaseUrl}movie/top_rated";
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
        return left(res.message);
      }
    }
    catch(e){
      return left(e.toString());
    }
  }

  Future<Either<String,TmdbMovieResponseModel>> getMovieSearchResults(String query)async{
    TmdbMovieResponseModel topRatedModel;
    String token = ApiEndpoints.tmdbApiKey;
    String url = "${ApiEndpoints.tmdbBaseUrl}search/movie?query=$query&api_key=$token";

    try {
      var res = await ApiHelper().request(url: url, headers: {}, method: HTTPMETHOD.GET);
      if (res.statusCode == 200) {
        topRatedModel = TmdbMovieResponseModel.fromJson(res.data);
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