import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_collection/models/books/google_books_api_response_model.dart';
import 'package:my_collection/utils/data_utils.dart';
import 'package:uuid/uuid.dart';

class ReadingListProvider extends ChangeNotifier {
  late TextEditingController readingListNameTextController;
  late FocusNode readingListNameNode;
  late FirebaseAuth firebaseAuth;
  late FirebaseFirestore db;
  late Uuid uuid;
  List<GoogleBooksApiResponseModel> readingLists = List.empty(growable: true);
  late GoogleBooksApiResponseModel selectedReadingListModel;

  int selectedReadingListIndex = -1;
  bool isLoadingReadingLists = false;

  ReadingListProvider() {
    readingListNameTextController = TextEditingController();
    readingListNameNode = FocusNode();
    db = FirebaseFirestore.instance;
    firebaseAuth = FirebaseAuth.instance;
    uuid = const Uuid();
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
    readingLists = snapshot.docs.map((e) => GoogleBooksApiResponseModel.fromJson(e.data())).toList();

    notifyListeners();
  }

  void setSelectedReadingListModel(GoogleBooksApiResponseModel model) {
    selectedReadingListModel = model;
    notifyListeners();
  }

  Future<void> createNewReadingList() async {
    final User? user = firebaseAuth.currentUser;
    selectedReadingListModel = GoogleBooksApiResponseModel(kind: readingListNameTextController.text, totalItems: [].length, items: []);
    var snapshot = await db
        .collection("users")
        .doc(user?.email)
        .collection("reading-lists")
        .doc(selectedReadingListModel.kind)
        .set(selectedReadingListModel.toJson());

    List<String> readingListNames = [];
    for (var val in BookShelves.values){
      readingListNames.add(DataUtils.getBookshelfStringFromEnum(val));
    }
    for (GoogleBooksApiResponseModel i in readingLists){
      if(readingListNames.contains(i.kind)){
        continue;
      }
      else{
        createBatchReadingList();
      }
    }

    fetchReadingLists();
  }

  Future<void> createBatchReadingList() async {
    debugPrint("createBatchReadingList: Committing batch");
    var batch = db.batch();
    final User? user = firebaseAuth.currentUser;

    for(var val in BookShelves.values){
      String value = DataUtils.getBookshelfStringFromEnum(val);
      selectedReadingListModel = GoogleBooksApiResponseModel(kind: value, totalItems: [].length, items: []);
      batch.set(db
          .collection("users")
          .doc(user?.email)
          .collection("reading-lists")
          .doc(selectedReadingListModel.kind), selectedReadingListModel.toJson());
    }
    await batch.commit();
  }

  Future<void> addNewBookToReadingList(BookListItem book) async {
    final User? user = firebaseAuth.currentUser;
    List<BookListItem> books = selectedReadingListModel.items;
    books.add(book);
    selectedReadingListModel = selectedReadingListModel.copyWith(items: books);

    var snapshot = await db
        .collection("users")
        .doc(user?.email)
        .collection("reading-lists")
        .doc(selectedReadingListModel.kind)
        .set(selectedReadingListModel.toJson());
    fetchReadingLists();
  }
}
