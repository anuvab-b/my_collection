import 'dart:async';
import 'dart:isolate';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_collection/domain/i_movie_repository.dart';
import 'package:my_collection/models/movies/tmdb_movie_credits_response_model.dart';
import 'package:my_collection/models/movies/tmdb_movie_details_response_model.dart';
import 'package:my_collection/models/movies/tmdb_movie_response_model.dart';

Future<void> getNowPlayingIsolate(List<Object> args) async {
  final rootIsolateToken = args[0] as RootIsolateToken;
  final sendPort = args[1] as SendPort;
  final movieRepository = args[2] as IMovieRepository;

  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

  var result = await movieRepository.fetchNowPlayingMovies();
  sendPort.send(result);
}

Future<void> getPopularIsolate(List<Object> args) async {
  final rootIsolateToken = args[0] as RootIsolateToken;
  final sendPort = args[1] as SendPort;
  final movieRepository = args[2] as IMovieRepository;

  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

  var result = await movieRepository.fetchPopularMovies();
  sendPort.send(result);
}

Future<void> getUpcomingIsolate(List<Object> args) async {
  final rootIsolateToken = args[0] as RootIsolateToken;
  final sendPort = args[1] as SendPort;
  final movieRepository = args[2] as IMovieRepository;

  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

  var result = await movieRepository.fetchUpcomingMovies();
  sendPort.send(result);
}

Future<void> getTopRatedIsolate(List<Object> args) async {
  final rootIsolateToken = args[0] as RootIsolateToken;
  final sendPort = args[1] as SendPort;
  final movieRepository = args[2] as IMovieRepository;

  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

  var result = await movieRepository.fetchTopRatedMovies();
  sendPort.send(result);
}

class MovieProvider extends ChangeNotifier{
  final IMovieRepository movieRepository;
  MovieProvider({required this.movieRepository});


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
  bool isMovieDetailsLoading = false;
  bool isMovieCreditsLoading = false;

  int pageIndex = 0;
  int selectedPageIndex = 0;

  String searchQuery = "";

  MovieListModel? selectedMovieListModel;
  TmdbMovieResponseModel? movieSearchResponseModel;
  TmdbMovieCreditsResponseModel? movieCreditsResponseModel;
  TmdbMovieDetailsResponseModel? movieDetailsResponseModel;
  Map<String, Either<String, TmdbMovieResponseModel>?> movieSearchMap = {};

  void fetchMovieHomeData(){
    getNowPlayingMovies();
    getPopularMovies();
    getTopRatedMovies();
    getUpcomingMovies();
  }


  Future<void> getUpcomingMovies() async {
    isUpcomingLoading = true;
    notifyListeners();
    RootIsolateToken? rootIsolateToken = RootIsolateToken.instance;
    if(rootIsolateToken == null){
      debugPrint("Cannot get the Root Isolate Token");
      return;
    }
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(getUpcomingIsolate, [rootIsolateToken,receivePort.sendPort,movieRepository]);

    receivePort.listen((message) {
      message.fold((l){
        debugPrint("Went in left");
      },(r){
        upcomingMovieList = r.results;
        debugPrint("Went in right");
      });
      isUpcomingLoading = false;
      notifyListeners();
    });
  }

  Future<void> getPopularMovies() async {
    isPopularLoading = true;
    notifyListeners();
    RootIsolateToken? rootIsolateToken = RootIsolateToken.instance;
    if(rootIsolateToken == null){
      debugPrint("Cannot get the Root Isolate Token");
      return;
    }
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(getPopularIsolate, [rootIsolateToken,receivePort.sendPort,movieRepository]);

    receivePort.listen((message) {
      message.fold((l){
        debugPrint("Went in left");
      },(r){
        popularMovieList = r.results;
        debugPrint("Went in right");
      });
      isPopularLoading = false;
      notifyListeners();
    });

  }

  Future<void> getNowPlayingMovies() async {
    isNowPlayingLoading = true;
    notifyListeners();
    RootIsolateToken? rootIsolateToken = RootIsolateToken.instance;
    if(rootIsolateToken == null){
      debugPrint("Cannot get the Root Isolate Token");
      return;
    }
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(getNowPlayingIsolate, [rootIsolateToken,receivePort.sendPort,movieRepository]);

    receivePort.listen((message) {
      message.fold((l){
        debugPrint("Went in left");
      },(r){
        nowPlayingMovieList = r.results;
        debugPrint("Went in right");
      });
      isNowPlayingLoading = false;
      notifyListeners();
    });
  }

  Future<void> getTopRatedMovies() async {
    isTopRatedLoading = true;
    notifyListeners();
    RootIsolateToken? rootIsolateToken = RootIsolateToken.instance;
    if(rootIsolateToken == null){
      debugPrint("Cannot get the Root Isolate Token");
      return;
    }
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(getTopRatedIsolate, [rootIsolateToken,receivePort.sendPort,movieRepository]);

    receivePort.listen((message) {
      message.fold((l){
        debugPrint("Went in left");
      },(r){
        topRatedMovieList = r.results;
        debugPrint("Went in right");
      });
      isTopRatedLoading = false;
      notifyListeners();
    });
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

  setSelectedMovieListItem(MovieListModel item){
    selectedMovieListModel = item;
    notifyListeners();
  }

  Future<void> fetchMovieDetails() async {
    isMovieDetailsLoading = true;
    notifyListeners();
    var result = await movieRepository.getMovieDetails("${selectedMovieListModel?.id}");
    isMovieDetailsLoading = false;
    notifyListeners();
    result.fold((l){}, (r){
      movieDetailsResponseModel = r;
    });
  }

  Future<void> fetchMovieCredits() async {
    isMovieCreditsLoading = true;
    notifyListeners();
    var result = await movieRepository.getMovieCredits("${selectedMovieListModel?.id}");
    isMovieCreditsLoading = false;
    notifyListeners();
    result.fold((l){}, (r){
      movieCreditsResponseModel = r;
    });
  }
}