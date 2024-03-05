import 'package:dartz/dartz.dart';
import 'package:my_collection/models/movies/tmdb_movie_credits_response_model.dart';
import 'package:my_collection/models/movies/tmdb_movie_details_response_model.dart';
import 'package:my_collection/models/movies/tmdb_movie_response_model.dart';

abstract class IMovieRepository{
  Future<Either<String,TmdbMovieResponseModel>> fetchNowPlayingMovies();
  Future<Either<String,TmdbMovieResponseModel>> fetchPopularMovies();
  Future<Either<String,TmdbMovieResponseModel>> fetchUpcomingMovies();
  Future<Either<String,TmdbMovieResponseModel>> fetchTopRatedMovies();
  Future<Either<String,TmdbMovieResponseModel>> getMovieSearchResults(String query);
  Future<Either<String,TmdbMovieCreditsResponseModel>> getMovieCredits(String movieId);
  Future<Either<String,TmdbMovieDetailsResponseModel>> getMovieDetails(String movieId);
}