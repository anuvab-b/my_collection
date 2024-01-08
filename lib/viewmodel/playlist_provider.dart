import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_collection/models/music/playlists/playlist_model.dart';
import 'package:my_collection/models/music/spotify_search_response_model.dart';
import 'package:uuid/uuid.dart';

class PlayListProvider extends ChangeNotifier {
  late TextEditingController playListNameTextController;
  late FocusNode playListNameNode;
  late FirebaseAuth firebaseAuth;
  late FirebaseFirestore db;
  late Uuid uuid;
  PlayListModel? selectedPlayListModel;
  List<PlayListModel> playLists = List.empty(growable: true);

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
    notifyListeners();
  }
}