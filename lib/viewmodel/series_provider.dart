import 'package:flutter/cupertino.dart';
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

  int pageIndex = 0;
  int selectedPageIndex = 0;

  Future<void> getAiringToday() async {
    isUpcomingLoading = true;
    notifyListeners();
    var result = await seriesRepository.fetchAiringToday();
    isUpcomingLoading = false;
    result.fold((l){}, (r){
      airingTodaySeriesList = r.results!;
    });
    notifyListeners();

  }

  Future<void> getOnTheAir() async {
    isPopularLoading = true;
    notifyListeners();
    var result = await seriesRepository.fetchOnTheAir();
    isPopularLoading = false;
    result.fold((l){}, (r){
      onTheAirSeriesList = r.results!;
    });
    notifyListeners();

  }

  Future<void> getPopular() async {
    isNowPlayingLoading = true;
    notifyListeners();
    var result = await seriesRepository.fetchPopular();
    isNowPlayingLoading = false;
    result.fold((l){}, (r){
      popularSeriesList = r.results!;
    });
    notifyListeners();

  }

  Future<void> getTopRated() async {
    isTopRatedLoading = true;
    notifyListeners();
    var result = await seriesRepository.fetchTopRatedSeries();
    isTopRatedLoading = false;
    result.fold((l){}, (r){
      topRatedSeriesList = r.results!;
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

}