import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_collection/models/music/playlists/playlist_model.dart';
import 'package:my_collection/models/music/spotify_search_response_model.dart';
import 'package:my_collection/utils/data_utils.dart';
import 'package:uuid/uuid.dart';

class PlayListProvider extends ChangeNotifier {
  late TextEditingController playListNameTextController;
  late FocusNode playListNameNode;
  late FirebaseAuth firebaseAuth;
  late FirebaseFirestore db;
  late Uuid uuid;
  PlayListModel? selectedPlayListModel;
  List<PlayListModel> playLists = List.empty(growable: true);
  int selectedPlayListIndex = -1;

  bool isLoadingPlayLists = false;

  PlayListProvider() {
    playListNameTextController = TextEditingController();
    playListNameNode = FocusNode();
    db = FirebaseFirestore.instance;
    firebaseAuth = FirebaseAuth.instance;
    uuid = const Uuid();
  }

  Future<void> createNewPlayList() async {
    final User? user = firebaseAuth.currentUser;
    selectedPlayListModel = PlayListModel(
        items: [], name: playListNameTextController.text, uuid: uuid.v4());
    var snapshot = await db
        .collection("users")
        .doc(user?.email)
        .collection("music-playlists")
        .doc(selectedPlayListModel!.name)
        .set(selectedPlayListModel!.toJson());
    fetchMusicPlayLists();
  }

  Future<void> addNewSongToPlayList(TracksItem tracksItem, int index) async {
    final User? user = firebaseAuth.currentUser;
    selectedPlayListModel = playLists[index];
    List<PlayListItem> playListItems = selectedPlayListModel!.items;
    PlayListItem playListItem = PlayListItem(
        name: tracksItem.name!,
        artists: tracksItem.artists,
        album: tracksItem.album);
    playListItems.add(playListItem);

    selectedPlayListModel =
        selectedPlayListModel!.copyWith(items: playListItems);

    var snapshot = await db
        .collection("users")
        .doc(user?.email)
        .collection("music-playlists")
        .doc(selectedPlayListModel!.name)
        .set(selectedPlayListModel!.toJson());
    fetchMusicPlayLists();
  }

  Future<void> fetchMusicPlayLists() async {
    final User? user = firebaseAuth.currentUser;

    List<String> musicPlaylistNames = [];
    for (var val in MusicPlaylists.values) {
      musicPlaylistNames.add(DataUtils.getMusicPlaylistStringFromEnum(val));
    }

    isLoadingPlayLists = true;
    notifyListeners();

    var snapshot = await db
        .collection("users")
        .doc(user?.email)
        .collection("music-playlists")
        .get()
        .catchError((e) {
      debugPrint(e.toString());
      return e;
    });

    isLoadingPlayLists = false;
    playLists =
        snapshot.docs.map((e) => PlayListModel.fromJson(e.data())).toList();
    for (PlayListModel i in playLists) {
      if (musicPlaylistNames.contains(i?.name)) {
        continue;
      } else {
        createBatchPlaylist();
        break;
      }
    }

    notifyListeners();
  }

  setSelectedPlayListIndex(int index){
    selectedPlayListIndex = index;
    notifyListeners();
  }

  Future<void> createBatchPlaylist() async {
    debugPrint("createBatchSeriesWatchList: Committing batch");
    var batch = db.batch();
    final User? user = firebaseAuth.currentUser;

    for(var val in MusicPlaylists.values){
      String value = DataUtils.getMusicPlaylistStringFromEnum(val);
      selectedPlayListModel = PlayListModel(items: [],name: value,uuid: uuid.v4());
      batch.set(db
          .collection("users")
          .doc(user?.email)
          .collection("music-playlists")
          .doc(selectedPlayListModel!.name), selectedPlayListModel!.toJson());
    }
    await batch.commit();
  }
}