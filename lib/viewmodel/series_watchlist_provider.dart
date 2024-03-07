import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_collection/models/tv/tmdb_tv_response_model.dart';
import 'package:my_collection/utils/data_utils.dart';
import 'package:uuid/uuid.dart';

class SeriesWatchListProvider extends ChangeNotifier {
  late TextEditingController seriesWatchListNameTextController;
  late FocusNode seriesWatchListNameNode;
  late FirebaseAuth firebaseAuth;
  late FirebaseFirestore db;
  late Uuid uuid;
  List<TmdbTvResponseModel> seriesWatchLists = List.empty(growable: true);
  TmdbTvResponseModel? selectedSeriesWatchListModel;

  int selectedSeriesWatchListIndex = -1;
  bool isLoadingSeriesWatchLists = false;

  SeriesWatchListProvider() {
    seriesWatchListNameTextController = TextEditingController();
    seriesWatchListNameNode = FocusNode();
    db = FirebaseFirestore.instance;
    firebaseAuth = FirebaseAuth.instance;
    uuid = const Uuid();
  }

  void setSelectedWatchListModel(TmdbTvResponseModel model) {
    selectedSeriesWatchListModel = model;
    notifyListeners();
  }

  Future<void> fetchWatchListLists() async {
    final User? user = firebaseAuth.currentUser;

    isLoadingSeriesWatchLists = true;
    notifyListeners();

    var snapshot = await db
        .collection("users")
        .doc(user?.email)
        .collection("series-watchlists")
        .get()
        .catchError((e) {
      debugPrint(e.toString());
      return e;
    });

    isLoadingSeriesWatchLists = false;
    seriesWatchLists = snapshot.docs
        .map((e) => TmdbTvResponseModel.fromJson(e.data()))
        .toList();

    notifyListeners();
  }

  Future<void> createNewSeriesWatchList() async {
    final User? user = firebaseAuth.currentUser;

    selectedSeriesWatchListModel = TmdbTvResponseModel(
        results: [],
        name: seriesWatchListNameTextController.text,
        uuid: uuid.v4());
    var snapshot = await db
        .collection("users")
        .doc(user?.email)
        .collection("series-watchlists")
        .doc(selectedSeriesWatchListModel!.name)
        .set(selectedSeriesWatchListModel!.toJson());

    await fetchWatchListLists();

    List<String> seriesWatchlistNames = [];
    for (var val in SeriesWatchLists.values) {
      seriesWatchlistNames.add(DataUtils.getSeriesWatchlistStringFromEnum(val));
    }
    for (TmdbTvResponseModel i in seriesWatchLists) {
      if (seriesWatchlistNames.contains(i?.name)) {
        continue;
      } else {
        createBatchSeriesWatchList();
        break;
      }
    }
  }

  Future<void> addNewSeriesToWatchList(
      SeriesListModel series, int index) async {
    final User? user = firebaseAuth.currentUser;
    List<SeriesListModel> seriesList = selectedSeriesWatchListModel!.results;
    seriesList.add(series);
    selectedSeriesWatchListModel =
        selectedSeriesWatchListModel!.copyWith(results: seriesList);

    var snapshot = await db
        .collection("users")
        .doc(user?.email)
        .collection("series-watchlists")
        .doc(selectedSeriesWatchListModel!.name)
        .set(selectedSeriesWatchListModel!.toJson());
    fetchWatchListLists();
  }

  Future<void> createBatchSeriesWatchList() async {
    debugPrint("createBatchSeriesWatchList: Committing batch");
    var batch = db.batch();
    final User? user = firebaseAuth.currentUser;

    for (var val in SeriesWatchLists.values) {
      String value = DataUtils.getSeriesWatchlistStringFromEnum(val);
      selectedSeriesWatchListModel =
          TmdbTvResponseModel(results: [], name: value, uuid: uuid.v4());
      batch.set(
          db
              .collection("users")
              .doc(user?.email)
              .collection("series-watchlists")
              .doc(selectedSeriesWatchListModel!.name),
          selectedSeriesWatchListModel!.toJson());
    }
    await batch.commit();
    fetchWatchListLists();
  }
}
