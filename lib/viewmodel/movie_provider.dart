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
  List<MovieListModel> yourBookmarksList = List.empty(growable: true);
  List<MovieListModel> yourLikedList = List.empty(growable: true);
  List<MovieListModel> yourCurrentlyWatchingList = List.empty(growable: true);
  PageController pageController = PageController(initialPage: 0);

  bool isUpcomingLoading = false;
  bool isPopularLoading = false;
  bool isNowPlayingLoading = false;
  bool isTopRatedLoading = false;
  bool isSearchLoading = false;

  int pageIndex = 0;
  int selectedPageIndex = 0;

  String searchQuery = "";

  TmdbMovieResponseModel? movieSearchResponseModel;
  Map<String, Either<String, TmdbMovieResponseModel>?> movieSearchMap = {};


  Future<void> getUpcomingMovies() async {
    isUpcomingLoading = true;
    notifyListeners();
    var result = await movieRepository.fetchUpcomingMovies();
    isUpcomingLoading = false;
    result.fold((l){}, (r){
      upcomingMovieList = r.results.length > 3 ? r.results.sublist(0,3):r.results;
    });
    notifyListeners();

  }

  Future<void> getPopularMovies() async {
    isPopularLoading = true;
    notifyListeners();
    var result = await movieRepository.fetchPopularMovies();
    isPopularLoading = false;
    result.fold((l){}, (r){
      popularMovieList = r.results.length > 3 ? r.results.sublist(0,3):r.results;
    });
    notifyListeners();

  }

  Future<void> getNowPlayingMovies() async {
    isNowPlayingLoading = true;
    notifyListeners();
    var result = await movieRepository.fetchNowPlayingMovies();
    isNowPlayingLoading = false;
    result.fold((l){}, (r){
      nowPlayingMovieList = r.results.length > 3 ? r.results.sublist(0,3):r.results;
    });
    notifyListeners();

  }

  Future<void> getTopRatedMovies() async {
    isTopRatedLoading = true;
    notifyListeners();
    var result = await movieRepository.fetchTopRatedMovies();
    isTopRatedLoading = false;
    result.fold((l){}, (r){
      topRatedMovieList = r.results.length > 3 ? r.results.sublist(0,3):r.results;
    });
    notifyListeners();
  }

  storeIndex(int value){
    pageIndex = value;
    if(pageIndex == 0) {
      selectedPageIndex = pageIndex;
    } else if(nowPlayingMovieList.length<3) {
      selectedPageIndex = pageIndex;
    } else if (nowPlayingMovieList.length>=3 && pageIndex >= 1 && pageIndex < nowPlayingMovieList.length-1) {
      selectedPageIndex = 1;
    } else {
      selectedPageIndex = 2;
    }
    notifyListeners();
  }

  void onSearchQueryChanged(String query){
    searchQuery = query;
    notifyListeners();
  }

  Future<Either<String, TmdbMovieResponseModel>?> getMovieBySearch(
      String query) async {
    Either<String, TmdbMovieResponseModel>? result;
    if (movieSearchMap.containsKey(query)) {
      result = movieSearchMap[query];
    } else {
      if(query.isNotEmpty) {
        result = await movieRepository.getMovieSearchResults(query);
        if (query.isNotEmpty) {
          movieSearchMap.putIfAbsent(query, () => result);
        }
        result.fold((l) {}, (r) {
          movieSearchResponseModel = r;
        });
      }
    }
    return result;
  }

}