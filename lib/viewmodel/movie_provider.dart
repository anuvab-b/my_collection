import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:my_collection/models/movies/tmdb_movie_response_model.dart';
import 'package:my_collection/repository/movies/movie_repository.dart';

class MovieProvider extends ChangeNotifier{

  MovieRepository movieRepository = MovieRepository();


  List<MovieListModel> upcomingMovieList = List.empty(growable: true);
  List<MovieListModel> popularMovieList = List.empty(growable: true);
  List<MovieListModel> nowPlayingMovieList = List.empty(growable: true);
  List<MovieListModel> topRatedMovieList = List.empty(growable: true);

  bool isUpcomingLoading = false;
  bool isPopularLoading = false;
  bool isNowPlayingLoading = false;
  bool isTopRatedLoading = false;

  Future<void> getUpcomingMovies() async {
    isUpcomingLoading = true;
    notifyListeners();
    var result = await movieRepository.fetchUpcomingMovies();
    isUpcomingLoading = false;
    result.fold((l){}, (r){
      upcomingMovieList = r.results!;
    });
    notifyListeners();

  }

  Future<void> getPopularMovies() async {
    isPopularLoading = true;
    notifyListeners();
    var result = await movieRepository.fetchPopularMovies();
    isPopularLoading = false;
    result.fold((l){}, (r){
      popularMovieList = r.results!;
    });
    notifyListeners();

  }

  Future<void> getNowPlayingMovies() async {
    isNowPlayingLoading = true;
    notifyListeners();
    var result = await movieRepository.fetchNowPlayingMovies();
    isNowPlayingLoading = false;
    result.fold((l){}, (r){
      nowPlayingMovieList = r.results!;
    });
    notifyListeners();

  }

  Future<void> getTopRatedMovies() async {
    isTopRatedLoading = true;
    notifyListeners();
    var result = await movieRepository.fetchTopRatedMovies();
    isTopRatedLoading = false;
    result.fold((l){}, (r){
      topRatedMovieList = r.results!;
    });
    notifyListeners();
  }

}