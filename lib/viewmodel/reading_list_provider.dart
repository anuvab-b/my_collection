import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class ReadingListProvider extends ChangeNotifier {
  late TextEditingController readingListNameTextController;
  late FocusNode readingListNameNode;
  late FirebaseAuth firebaseAuth;
  late FirebaseFirestore db;
  late Uuid uuid;
  List<dynamic> readingLists = List.empty(growable: true);
  var selectedReadingListModel;

  int selectedReadingListIndex = -1;
  bool isLoadingReadingLists = false;

  ReadingListProvider() {
    readingListNameTextController = TextEditingController();
    readingListNameNode = FocusNode();
    db = FirebaseFirestore.instance;
    firebaseAuth = FirebaseAuth.instance;
    uuid = const Uuid();
  }

  void setSelectedReadingListIndex(int index) {
    selectedReadingListIndex = index;
    notifyListeners();
  }

  Future<void> fetchReadingLists() async {
    final User? user = firebaseAuth.currentUser;

    isLoadingReadingLists = true;
    notifyListeners();

    var snapshot = await db
        .collection("users")
        .doc(user?.email)
        .collection("reading-lists")
        .get()
        .catchError((e) {
      debugPrint(e.toString());
      return e;
    });

    isLoadingReadingLists = false;
    readingLists = snapshot.docs.map((e) => e.data()).toList();
    notifyListeners();
  }

  Future<void> createNewReadingList() async {
    final User? user = firebaseAuth.currentUser;
    selectedReadingListModel = {};
    var snapshot = await db
        .collection("users")
        .doc(user?.email)
        .collection("reading-lists")
        .doc(selectedReadingListModel.name)
        .set(selectedReadingListModel.toJson());

    fetchReadingLists();
  }

  Future<void> addNewBookToReadingList(var book, int index) async {
    final User? user = firebaseAuth.currentUser;
    List<dynamic> books = selectedReadingListModel.items;
    var book = {};
    books.add(book);
    selectedReadingListModel = selectedReadingListModel.copyWith(items: books);

    var snapshot = await db
        .collection("users")
        .doc(user?.email)
        .collection("reading-lists")
        .doc(selectedReadingListModel.name)
        .set(selectedReadingListModel.toJson());
    fetchReadingLists();
  }
}
