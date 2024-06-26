import 'package:dartz/dartz.dart';
import 'package:my_collection/data/network/api_endpoints.dart';
import 'package:my_collection/data/network/network.dart';
import 'package:my_collection/data/network/secrets.dart';
import 'package:my_collection/domain/i_movie_repository.dart';
import 'package:my_collection/models/movies/tmdb_movie_credits_response_model.dart';
import 'package:my_collection/models/movies/tmdb_movie_details_response_model.dart';
import 'package:my_collection/models/movies/tmdb_movie_response_model.dart';

class MovieRepository extends IMovieRepository{
  ApiHelper apiHelper;
  MovieRepository({required this.apiHelper});
  @override
  Future<Either<String,TmdbMovieResponseModel>> fetchNowPlayingMovies() async{
    TmdbMovieResponseModel nowPlayingModel;
    String url = "${ApiEndpoints.tmdbBaseUrl}movie/now_playing";
    String token = Secrets.tmdbToken;

    try {
      var res = await apiHelper.request(url: url, headers: {
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

  @override
  Future<Either<String,TmdbMovieResponseModel>> fetchPopularMovies() async{
    TmdbMovieResponseModel upcomingModel;
    String url = "${ApiEndpoints.tmdbBaseUrl}movie/popular";
    String token = Secrets.tmdbToken;
    try {
      var res = await apiHelper.request(url: url, headers: {
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

  @override
  Future<Either<String,TmdbMovieResponseModel>> fetchUpcomingMovies()async{
    TmdbMovieResponseModel upcomingModel;
    String url = "${ApiEndpoints.tmdbBaseUrl}movie/upcoming";
    String token = Secrets.tmdbToken;
    try {
      var res = await apiHelper.request(url: url, headers: {
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

  @override
  Future<Either<String,TmdbMovieResponseModel>> fetchTopRatedMovies()async{
    TmdbMovieResponseModel topRatedModel;
    String url = "${ApiEndpoints.tmdbBaseUrl}movie/top_rated";
    String token = Secrets.tmdbToken;
    try {
      var res = await apiHelper.request(url: url, headers: {
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

  @override
  Future<Either<String,TmdbMovieResponseModel>> getMovieSearchResults(String query)async{
    TmdbMovieResponseModel topRatedModel;
    String token = Secrets.tmdbApiKey;
    String url = "${ApiEndpoints.tmdbBaseUrl}search/movie?query=$query&api_key=$token";

    try {
      var res = await apiHelper.request(url: url, headers: {}, method: HTTPMETHOD.GET);
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

  @override
  Future<Either<String,TmdbMovieCreditsResponseModel>> getMovieCredits(String movieId) async{
    TmdbMovieCreditsResponseModel creditsResponseModel;
    String token = Secrets.tmdbApiKey;
    String url = "${ApiEndpoints.tmdbBaseUrl}movie/$movieId/credits?api_key=$token";

    try {
      var res = await apiHelper.request(url: url, headers: {}, method: HTTPMETHOD.GET);
      if (res.statusCode == 200) {
        creditsResponseModel = TmdbMovieCreditsResponseModel.fromJson(res.data);
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
  Future<Either<String,TmdbMovieDetailsResponseModel>> getMovieDetails(String movieId) async{
    TmdbMovieDetailsResponseModel responseModel;
    String token = Secrets.tmdbApiKey;
    String url = "${ApiEndpoints.tmdbBaseUrl}movie/$movieId?api_key=$token";

    try {
      var res = await apiHelper.request(url: url, headers: {}, method: HTTPMETHOD.GET);
      if (res.statusCode == 200) {
        responseModel = TmdbMovieDetailsResponseModel.fromJson(res.data);
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