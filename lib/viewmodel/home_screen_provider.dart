import 'package:flutter/cupertino.dart';
import 'package:my_collection/viewmodel/movie_provider.dart';
import 'package:provider/provider.dart';

class HomeScreenProvider extends ChangeNotifier{

  int selectedIndex = 0;
  onBottomNavIndexChanged(int index,BuildContext context){

    MovieProvider movieProvider = Provider.of<MovieProvider>(context, listen: false);
    movieProvider.getNowPlayingMovies();
    movieProvider.getPopularMovies();
    movieProvider.getTopRatedMovies();
    movieProvider.getUpcomingMovies();
    selectedIndex = index;
    notifyListeners();
  }
}