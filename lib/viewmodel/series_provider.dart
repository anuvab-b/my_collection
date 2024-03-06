import 'dart:isolate';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:my_collection/domain/i_series_repository.dart';
import 'package:my_collection/models/tv/tmdb_tv_agg_credits_response_model.dart';
import 'package:my_collection/models/tv/tmdb_tv_details_response_model.dart';
import 'package:my_collection/models/tv/tmdb_tv_response_model.dart';

Future<void> getAiringTodayIsolate(List<Object> args) async {
  final rootIsolateToken = args[0] as RootIsolateToken;
  final sendPort = args[1] as SendPort;
  final seriesRepository = args[2] as ISeriesRepository;

  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

  var result = await seriesRepository.fetchAiringToday();
  sendPort.send(result);
}

Future<void> getOnTheAirIsolate(List<Object> args) async {
  final rootIsolateToken = args[0] as RootIsolateToken;
  final sendPort = args[1] as SendPort;
  final seriesRepository = args[2] as ISeriesRepository;

  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

  var result = await seriesRepository.fetchOnTheAir();
  sendPort.send(result);
}

Future<void> getPopularIsolate(List<Object> args) async {
  final rootIsolateToken = args[0] as RootIsolateToken;
  final sendPort = args[1] as SendPort;
  final seriesRepository = args[2] as ISeriesRepository;

  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

  var result = await seriesRepository.fetchPopular();
  sendPort.send(result);
}

Future<void> getTopRatedIsolate(List<Object> args) async {
  final rootIsolateToken = args[0] as RootIsolateToken;
  final sendPort = args[1] as SendPort;
  final seriesRepository = args[2] as ISeriesRepository;

  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

  var result = await seriesRepository.fetchTopRatedSeries();
  sendPort.send(result);
}
class SeriesProvider extends ChangeNotifier{

  ISeriesRepository seriesRepository;
  SeriesProvider({required this.seriesRepository});


  List<SeriesListModel> airingTodaySeriesList = List.empty(growable: true);
  List<SeriesListModel> onTheAirSeriesList = List.empty(growable: true);
  List<SeriesListModel> popularSeriesList = List.empty(growable: true);
  List<SeriesListModel> topRatedSeriesList = List.empty(growable: true);
  List<SeriesListModel> yourBookmarksSeriesList = List.empty(growable: true);
  List<SeriesListModel> yourLikedSeriesList = List.empty(growable: true);
  List<SeriesListModel> yourCurrentlyWatchingSeriesList = List.empty(growable: true);
  PageController pageController = PageController(initialPage: 0);

  bool isUpcomingLoading = false;
  bool isPopularLoading = false;
  bool isNowPlayingLoading = false;
  bool isTopRatedLoading = false;
  bool isOnTheAirLoading = false;
  bool isAiringTodayLoading = false;
  bool isSeriesDetailsLoading = false;
  bool isSeriesAggCreditsLoading = false;

  int pageIndex = 0;
  int selectedPageIndex = 0;
  String searchQuery = "";


  SeriesListModel? selectedSeriesListModel;
  TmdbTvResponseModel? seriesSearchResponseModel;
  TmdbTvAggCreditsResponseModel? seriesAggCreditsResponseModel;
  TmdbTvDetailsResponseModel? seriesDetailsResponseModel;
  Map<String, Either<String, TmdbTvResponseModel>?> seriesSearchMap = {};

  void onSearchQueryChanged(String query){
    searchQuery = query;
    notifyListeners();
  }

  void fetchSeriesHomeData(){
    getAiringToday();
    getOnTheAir();
    getPopular();
    getTopRated();
  }

  Future<void> getAiringToday() async {
    isAiringTodayLoading = true;
    notifyListeners();
    RootIsolateToken? rootIsolateToken = RootIsolateToken.instance;
    if(rootIsolateToken == null){
      debugPrint("Cannot get the Root Isolate Token");
      return;
    }
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(getAiringTodayIsolate, [rootIsolateToken,receivePort.sendPort,seriesRepository]);

    receivePort.listen((message) {
      message.fold((l){
        debugPrint("Went in left");
      },(r){
        airingTodaySeriesList = r.results;
        debugPrint("Went in right");
      });
      isNowPlayingLoading = false;
      notifyListeners();
    });
  }

  Future<void> getOnTheAir() async {
    isOnTheAirLoading = true;
    notifyListeners();

    RootIsolateToken? rootIsolateToken = RootIsolateToken.instance;
    if(rootIsolateToken == null){
      debugPrint("Cannot get the Root Isolate Token");
      return;
    }
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(getOnTheAirIsolate, [rootIsolateToken,receivePort.sendPort,seriesRepository]);

    receivePort.listen((message) {
      message.fold((l){
        debugPrint("Went in left");
      },(r){
        onTheAirSeriesList = r.results;
        debugPrint("Went in right");
      });
      isOnTheAirLoading = false;
      notifyListeners();
    });
  }

  Future<void> getPopular() async {
    isPopularLoading = true;
    notifyListeners();

    RootIsolateToken? rootIsolateToken = RootIsolateToken.instance;
    if(rootIsolateToken == null){
      debugPrint("Cannot get the Root Isolate Token");
      return;
    }
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(getPopularIsolate, [rootIsolateToken,receivePort.sendPort,seriesRepository]);

    receivePort.listen((message) {
      message.fold((l){
        debugPrint("Went in left");
      },(r){
        popularSeriesList = r.results;
        debugPrint("Went in right");
      });
      isPopularLoading = false;
      notifyListeners();
    });
  }

  Future<void> getTopRated() async {
    isTopRatedLoading = true;
    notifyListeners();

    RootIsolateToken? rootIsolateToken = RootIsolateToken.instance;
    if(rootIsolateToken == null){
      debugPrint("Cannot get the Root Isolate Token");
      return;
    }
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(getTopRatedIsolate, [rootIsolateToken,receivePort.sendPort,seriesRepository]);

    receivePort.listen((message) {
      message.fold((l){
        debugPrint("Went in left");
      },(r){
        topRatedSeriesList = r.results;
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
    } else if(popularSeriesList.length<3) {
      selectedPageIndex = pageIndex;
    } else if (popularSeriesList.length>=3 && pageIndex >= 1 && pageIndex < popularSeriesList.length-1) {
      selectedPageIndex = 1;
    } else {
      selectedPageIndex = 2;
    }
    notifyListeners();
  }

  Future<Either<String, TmdbTvResponseModel>?> getSeriesBySearch(
      String query) async {
    Either<String, TmdbTvResponseModel>? result;
    if (seriesSearchMap.containsKey(query)) {
      result = seriesSearchMap[query];
    } else {
      if(query.isNotEmpty) {
        result = await seriesRepository.getTvSearchResults(query);
        if (query.isNotEmpty) {
          seriesSearchMap.putIfAbsent(query, () => result);
        }
        result.fold((l) {}, (r) {
          seriesSearchResponseModel = r;
        });
      }
    }
    return result;
  }

  setSelectedSeriesListItem(SeriesListModel item){
    selectedSeriesListModel = item;
    notifyListeners();
  }

  Future<void> fetchSeriesDetails() async {
    isSeriesDetailsLoading = true;
    notifyListeners();
    var result = await seriesRepository.getSeriesDetails("${selectedSeriesListModel?.id}");
    isSeriesDetailsLoading = false;
    notifyListeners();
    result.fold((l){}, (r){
      seriesDetailsResponseModel = r;
    });
  }

  Future<void> fetchSeriesAggCredits() async {
    isSeriesAggCreditsLoading = true;
    notifyListeners();
    var result = await seriesRepository.getSeriesAggCredits("${selectedSeriesListModel?.id}");
    isSeriesAggCreditsLoading = false;
    notifyListeners();
    result.fold((l){}, (r){
      seriesAggCreditsResponseModel = r;
    });
  }
}