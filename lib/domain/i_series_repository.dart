import 'package:dartz/dartz.dart';
import 'package:my_collection/models/tv/tmdb_tv_agg_credits_response_model.dart';
import 'package:my_collection/models/tv/tmdb_tv_details_response_model.dart';
import 'package:my_collection/models/tv/tmdb_tv_response_model.dart';

abstract class ISeriesRepository{
  Future<Either<String,TmdbTvResponseModel>> fetchAiringToday();
  Future<Either<String,TmdbTvResponseModel>> fetchOnTheAir();
  Future<Either<String,TmdbTvResponseModel>> fetchPopular();
  Future<Either<String,TmdbTvResponseModel>> fetchTopRatedSeries();
  Future<Either<String,TmdbTvResponseModel>> getTvSearchResults(String query);
  Future<Either<String,TmdbTvAggCreditsResponseModel>> getSeriesAggCredits(String seriesId);
  Future<Either<String,TmdbTvDetailsResponseModel>> getSeriesDetails(String seriesId);

}