import 'package:flutter/cupertino.dart';
import 'package:my_collection/viewmodel/books_provider.dart';
import 'package:my_collection/viewmodel/movie_provider.dart';
import 'package:my_collection/viewmodel/movie_watchlist_provider.dart';
import 'package:my_collection/viewmodel/music_provider.dart';
import 'package:my_collection/viewmodel/playlist_provider.dart';
import 'package:my_collection/viewmodel/reading_list_provider.dart';
import 'package:my_collection/viewmodel/series_provider.dart';
import 'package:my_collection/viewmodel/series_watchlist_provider.dart';
import 'package:provider/provider.dart';

class HomeScreenProvider extends ChangeNotifier{

  int selectedIndex = 0;
  onBottomNavIndexChanged(int index,int currentIndex, BuildContext context) {
    if (index != currentIndex) {
      if (index == 0) {
        BooksProvider booksProvider = Provider.of<BooksProvider>(
            context, listen: false);
        ReadingListProvider readingListProvider = Provider.of<
            ReadingListProvider>(context, listen: false);
        booksProvider.fetchBookHomeScreenData();
        readingListProvider.fetchReadingLists();
      }

      if (index == 1) {
        MovieProvider movieProvider = Provider.of<MovieProvider>(context, listen: false);
        MovieWatchListProvider movieWatchListProvider = Provider.of<MovieWatchListProvider>(context, listen: false);

        movieProvider.fetchMovieHomeData();
        movieWatchListProvider.fetchMovieWatchlistLists();
      }
      else if (index == 2) {
        SeriesProvider seriesProvider = Provider.of<SeriesProvider>(context, listen: false);
        SeriesWatchListProvider seriesWatchListProvider = Provider.of<SeriesWatchListProvider>(context,listen: false);

        seriesProvider.fetchSeriesHomeData();
        seriesWatchListProvider.fetchWatchListLists();
      }

      else if (index == 3) {
        MusicProvider musicProvider = Provider.of<MusicProvider>(
            context, listen: false);
        PlayListProvider playListProvider = Provider.of<PlayListProvider>(
            context, listen: false);
        musicProvider.getToken();
        playListProvider.fetchMusicPlayLists();
      }
      selectedIndex = index;
      notifyListeners();
    }
  }
}