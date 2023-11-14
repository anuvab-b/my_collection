import 'package:flutter/cupertino.dart';
import 'package:my_collection/viewmodel/books_provider.dart';
import 'package:my_collection/viewmodel/movie_provider.dart';
import 'package:my_collection/viewmodel/series_provider.dart';
import 'package:provider/provider.dart';

class HomeScreenProvider extends ChangeNotifier{

  int selectedIndex = 0;
  onBottomNavIndexChanged(int index,BuildContext context){

    if(index == 0){
      BooksProvider booksProvider = Provider.of<BooksProvider>(context,listen: false);
      booksProvider.getBooksOnSelfImprovement();
      booksProvider.getBooksOnFinance();
      booksProvider.getBooksOnPsychology();
      booksProvider.getBooksOnCrime();
    }

    if(index == 1) {
      MovieProvider movieProvider = Provider.of<MovieProvider>(
          context, listen: false);
      movieProvider.getNowPlayingMovies();
      movieProvider.getPopularMovies();
      movieProvider.getTopRatedMovies();
      movieProvider.getUpcomingMovies();
    }
    else if(index == 2){
      SeriesProvider seriesProvider = Provider.of<SeriesProvider>(context,listen: false);
      seriesProvider.getAiringToday();
      seriesProvider.getOnTheAir();
      seriesProvider.getPopular();
      seriesProvider.getTopRated();
    }
    selectedIndex = index;
    notifyListeners();
  }
}