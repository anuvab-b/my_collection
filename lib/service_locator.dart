
import 'package:get_it/get_it.dart';
import 'package:my_collection/data/network/network.dart';
import 'package:my_collection/domain/i_books_repository.dart';
import 'package:my_collection/domain/i_movie_repository.dart';
import 'package:my_collection/domain/i_music_repository.dart';
import 'package:my_collection/domain/i_series_repository.dart';
import 'package:my_collection/repository/books_repository.dart';
import 'package:my_collection/repository/movies/movie_repository.dart';
import 'package:my_collection/repository/music_repository.dart';
import 'package:my_collection/repository/tv/series_repository.dart';

final getIt = GetIt.instance;
class ServiceLocator{

  static init(){
    getIt.registerSingleton<ApiHelper>(ApiHelper());
    getIt.registerSingleton<IMusicRepository>(MusicRepository(apiHelper: getIt.get<ApiHelper>()));
    getIt.registerSingleton<IBooksRepository>(BooksRepository(apiHelper: getIt.get<ApiHelper>()));
    getIt.registerSingleton<IMovieRepository>(MovieRepository(apiHelper: getIt.get<ApiHelper>()));
    getIt.registerSingleton<ISeriesRepository>(SeriesRepository(apiHelper: getIt.get<ApiHelper>()));
  }
}