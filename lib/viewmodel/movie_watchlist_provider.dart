import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_collection/models/movies/tmdb_movie_response_model.dart';
import 'package:my_collection/utils/data_utils.dart';
import 'package:uuid/uuid.dart';

class MovieWatchListProvider extends ChangeNotifier{
  late TextEditingController seriesMovieListNameTextController;
  late FocusNode seriesMovieListNameNode;
  late FirebaseAuth firebaseAuth;
  late FirebaseFirestore db;
  late Uuid uuid;
  List<TmdbMovieResponseModel> movieWatchLists = List.empty(growable: true);
  TmdbMovieResponseModel? selectedMovieWatchListModel;

  int selectedMovieWatchListIndex = -1;
  bool isLoadingMovieWatchLists = false;

  MovieWatchListProvider() {
    seriesMovieListNameTextController = TextEditingController();
    seriesMovieListNameNode = FocusNode();
    db = FirebaseFirestore.instance;
    firebaseAuth = FirebaseAuth.instance;
    uuid = const Uuid();
  }

  setSelectedMovieWatchListItem(TmdbMovieResponseModel item){
    selectedMovieWatchListModel = item;
    notifyListeners();
  }

  Future<void> fetchMovieWatchlistLists() async {
    final User? user = firebaseAuth.currentUser;

    isLoadingMovieWatchLists = true;
    notifyListeners();

    var snapshot = await db
        .collection("users")
        .doc(user?.email)
        .collection("movie-watchlists")
        .get()
        .catchError((e) {
      debugPrint(e.toString());
      return e;
    });

    isLoadingMovieWatchLists = false;
    movieWatchLists = snapshot.docs.map((e) => TmdbMovieResponseModel.fromJson(e.data())).toList();

    notifyListeners();
  }

  Future<void> createNewMovieWatchList() async {
    final User? user = firebaseAuth.currentUser;
    selectedMovieWatchListModel = TmdbMovieResponseModel(
      name: seriesMovieListNameTextController.text,
      uuid: uuid.v4(),
      results: []
    );
    var snapshot = await db
        .collection("users")
        .doc(user?.email)
        .collection("movie-watchlists")
        .doc(selectedMovieWatchListModel!.name)
        .set(selectedMovieWatchListModel!.toJson());

    List<String> movieWatchlistNames = [];
    for(var val in MovieWatchLists.values) {
      movieWatchlistNames.add(DataUtils.getMovieWatchlistStringFromEnum(val));
    }

    await fetchMovieWatchlistLists();

    for(TmdbMovieResponseModel i in movieWatchLists){
      if(movieWatchlistNames.contains(i?.name)){
        continue;
      }
      else{
        createBatchMovieWatchList();
        break;
      }
    }
  }

  Future<void> addNewMovieToWatchList(MovieListModel movie, int index) async {
    final User? user = firebaseAuth.currentUser;
    List<MovieListModel> movieList = selectedMovieWatchListModel!.results;
    movieList.add(movie);
    selectedMovieWatchListModel = selectedMovieWatchListModel!.copyWith(results: movieList);

    var snapshot = await db
        .collection("users")
        .doc(user?.email)
        .collection("movie-watchlists")
        .doc(selectedMovieWatchListModel!.name)
        .set(selectedMovieWatchListModel!.toJson());
    fetchMovieWatchlistLists();
  }

  Future<void> createBatchMovieWatchList() async {
    debugPrint("createBatchMovieWatchList: Committing batch");
    var batch = db.batch();
    final User? user = firebaseAuth.currentUser;

    for(var val in MovieWatchLists.values){
      String value = DataUtils.getMovieWatchlistStringFromEnum(val);
      selectedMovieWatchListModel = TmdbMovieResponseModel(results: [],name: value,uuid: uuid.v4());
      batch.set(db
          .collection("users")
          .doc(user?.email)
          .collection("movie-watchlists")
          .doc(selectedMovieWatchListModel!.name), selectedMovieWatchListModel!.toJson());
    }
    await batch.commit();
    fetchMovieWatchlistLists();
  }
}