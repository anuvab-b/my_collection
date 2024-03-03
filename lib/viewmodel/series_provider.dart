import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_collection/models/tv/tmdb_tv_agg_credits_response_model.dart';
import 'package:my_collection/models/tv/tmdb_tv_details_response_model.dart';
import 'package:my_collection/models/tv/tmdb_tv_response_model.dart';
import 'package:my_collection/repository/tv/series_repository.dart';

class SeriesProvider extends ChangeNotifier{
  SeriesRepository seriesRepository = SeriesRepository();


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

  Future<void> getAiringToday() async {
    isAiringTodayLoading = true;
    notifyListeners();
    var result = await seriesRepository.fetchAiringToday();
    isAiringTodayLoading = false;
    result.fold((l){}, (r){
      airingTodaySeriesList = r.results.length > 3 ? r.results.sublist(0,3):r.results;
    });
    notifyListeners();
  }

  Future<void> getOnTheAir() async {
    isOnTheAirLoading = true;
    notifyListeners();
    var result = await seriesRepository.fetchOnTheAir();
    isOnTheAirLoading = false;
    result.fold((l){}, (r){
      onTheAirSeriesList = r.results.length > 3 ? r.results.sublist(0,3):r.results;
    });
    notifyListeners();
  }

  Future<void> getPopular() async {
    isNowPlayingLoading = true;
    notifyListeners();
    var result = await seriesRepository.fetchPopular();
    isNowPlayingLoading = false;
    result.fold((l){}, (r){
      popularSeriesList = r.results.length > 3 ? r.results.sublist(0,3):r.results;
    });
    notifyListeners();
  }

  Future<void> getTopRated() async {
    isTopRatedLoading = true;
    notifyListeners();
    var result = await seriesRepository.fetchTopRatedSeries();
    isTopRatedLoading = false;
    result.fold((l){}, (r){
      topRatedSeriesList = r.results.length > 3 ? r.results.sublist(0,3):r.results;
    });
    notifyListeners();
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