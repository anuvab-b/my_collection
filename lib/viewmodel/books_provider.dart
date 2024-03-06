import 'dart:isolate';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_collection/domain/i_books_repository.dart';
import 'package:my_collection/models/books/google_books_api_response_model.dart';
import 'package:my_collection/utils/data_utils.dart';

Future<void> getSelfImprovementIsolate(List<Object> args) async {
  final rootIsolateToken = args[0] as RootIsolateToken;
  final sendPort = args[1] as SendPort;
  final booksRepository = args[2] as IBooksRepository;
  final String bookCategory = args[3] as String;
  final String bookOrderBy = args[4] as String;

  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

  var result = await booksRepository.fetchBooksByQuery(bookCategory,orderBy: bookOrderBy);
  sendPort.send(result);
}

Future<void> getFinanceIsolate(List<Object> args) async {
  final rootIsolateToken = args[0] as RootIsolateToken;
  final sendPort = args[1] as SendPort;
  final booksRepository = args[2] as IBooksRepository;
  final String bookCategory = args[3] as String;
  final String bookOrderBy = args[4] as String;

  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

  var result = await booksRepository.fetchBooksByQuery(bookCategory,orderBy: bookOrderBy);
  sendPort.send(result);
}

Future<void> getPsychologyIsolate(List<Object> args) async {
  final rootIsolateToken = args[0] as RootIsolateToken;
  final sendPort = args[1] as SendPort;
  final booksRepository = args[2] as IBooksRepository;
  final String bookCategory = args[3] as String;
  final String bookOrderBy = args[4] as String;

  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

  var result = await booksRepository.fetchBooksByQuery(bookCategory,orderBy: bookOrderBy);
  sendPort.send(result);
}

Future<void> getCrimeIsolate(List<Object> args) async {
  final rootIsolateToken = args[0] as RootIsolateToken;
  final sendPort = args[1] as SendPort;
  final booksRepository = args[2] as IBooksRepository;
  final String bookCategory = args[3] as String;
  final String bookOrderBy = args[4] as String;

  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

  var result = await booksRepository.fetchBooksByQuery(bookCategory,orderBy: bookOrderBy);
  sendPort.send(result);
}

class BooksProvider extends ChangeNotifier {
  final IBooksRepository booksRepository;
  BooksProvider({required this.booksRepository});

  Map<String,List<BookListItem>> bookDataMap = {};
  List<BookListItem> booksOnSelfImprovement = List.empty(growable: true);
  List<BookListItem> booksOnFinance = List.empty(growable: true);
  List<BookListItem> booksOnPsychology = List.empty(growable: true);
  List<BookListItem> booksOnCrime = List.empty(growable: true);

  BookFilterCategories filterCategory = BookFilterCategories.newest;

  bool isSelfImpLoading = false;
  bool isFinanceLoading = false;
  bool isPsychologyLoading = false;
  bool isCrimeLoading = false;
  String searchQuery = "";

  BookListItem? selectedBookListItem;

  void onSearchQueryChanged(String query){
    searchQuery = query;
    notifyListeners();
  }

  void fetchBookHomeScreenData(){
    getBooksOnSelfImprovement();
    getBooksOnFinance();
    getBooksOnPsychology();
    getBooksOnCrime();
  }

  Future<void> getBooksOnSelfImprovement() async {
    String bookCategory = DataUtils.getBookCategoryStringFromEnum(BookCategories.selfImprovement);

    if(bookDataMap.containsKey(bookCategory)){
      booksOnSelfImprovement = bookDataMap[bookCategory]!;
    }
    else {
      isSelfImpLoading = true;
      notifyListeners();

      RootIsolateToken? rootIsolateToken = RootIsolateToken.instance;
      if(rootIsolateToken == null){
        debugPrint("Cannot get the Root Isolate Token");
        return;
      }
      ReceivePort receivePort = ReceivePort();
      await Isolate.spawn(getSelfImprovementIsolate, [rootIsolateToken,receivePort.sendPort,booksRepository,bookCategory,DataUtils.getBookFilterStringFromEnum(filterCategory)]);

      receivePort.listen((message) {
        message.fold((l){
          debugPrint("Went in left");
        },(r){
          booksOnSelfImprovement = r.items;
          bookDataMap.putIfAbsent(bookCategory, () => booksOnSelfImprovement);
          debugPrint("Went in right");
        });
        isSelfImpLoading = false;
        notifyListeners();
      });
      notifyListeners();
    }
  }

  Future<void> getBooksOnFinance() async {
    String bookCategory = DataUtils.getBookCategoryStringFromEnum(BookCategories.finance);

    if(bookDataMap.containsKey(bookCategory)){
      booksOnFinance = bookDataMap[bookCategory]!;
    }
    else {
      isFinanceLoading = true;
      notifyListeners();

      RootIsolateToken? rootIsolateToken = RootIsolateToken.instance;
      if(rootIsolateToken == null){
        debugPrint("Cannot get the Root Isolate Token");
        return;
      }
      ReceivePort receivePort = ReceivePort();
      await Isolate.spawn(getFinanceIsolate, [rootIsolateToken,receivePort.sendPort,booksRepository,bookCategory,DataUtils.getBookFilterStringFromEnum(filterCategory)]);

      receivePort.listen((message) {
        message.fold((l){
          debugPrint("Went in left");
        },(r){
          booksOnFinance = r.items;
          bookDataMap.putIfAbsent(bookCategory, () => booksOnFinance);
          debugPrint("Went in right");
        });
        isFinanceLoading = false;
        notifyListeners();
      });
    }
    notifyListeners();
  }

  Future<void> getBooksOnPsychology() async {
    String bookCategory = DataUtils.getBookCategoryStringFromEnum(BookCategories.psychology);


    if(bookDataMap.containsKey(bookCategory)){
      booksOnPsychology = bookDataMap[bookCategory]!;
    }
    else {
      isPsychologyLoading = true;
      notifyListeners();

      RootIsolateToken? rootIsolateToken = RootIsolateToken.instance;
      if(rootIsolateToken == null){
        debugPrint("Cannot get the Root Isolate Token");
        return;
      }
      ReceivePort receivePort = ReceivePort();
      await Isolate.spawn(getPsychologyIsolate, [rootIsolateToken,receivePort.sendPort,booksRepository,bookCategory,DataUtils.getBookFilterStringFromEnum(filterCategory)]);

      receivePort.listen((message) {
        message.fold((l){
          debugPrint("Went in left");
        },(r){
          booksOnPsychology = r.items;
          bookDataMap.putIfAbsent(bookCategory, () => booksOnPsychology);
          debugPrint("Went in right");
        });
        isPsychologyLoading = false;
        notifyListeners();
      });
    }
    notifyListeners();
  }

  Future<void> getBooksOnCrime() async {
    String bookCategory = DataUtils.getBookCategoryStringFromEnum(BookCategories.crime);

    if(bookDataMap.containsKey(bookCategory)){
      booksOnCrime = bookDataMap[bookCategory]!;
    }
    else {
      isCrimeLoading = true;
      notifyListeners();

      RootIsolateToken? rootIsolateToken = RootIsolateToken.instance;
      if(rootIsolateToken == null){
        debugPrint("Cannot get the Root Isolate Token");
        return;
      }
      ReceivePort receivePort = ReceivePort();
      await Isolate.spawn(getCrimeIsolate, [rootIsolateToken,receivePort.sendPort,booksRepository,bookCategory,DataUtils.getBookFilterStringFromEnum(filterCategory)]);

      receivePort.listen((message) {
        message.fold((l){
          debugPrint("Went in left");
        },(r){
          booksOnCrime = r.items;
          bookDataMap.putIfAbsent(bookCategory, () => booksOnCrime);
          debugPrint("Went in right");
        });
        isCrimeLoading = false;
        notifyListeners();
      });
    }
    notifyListeners();
  }

  Future<Either<String,List<BookListItem>>> getBookBySearch(
      String query) async {
    List<BookListItem> bookList = [];
    if (bookDataMap.containsKey(query)) {
      bookList = bookDataMap[query]!;
    } else {
      if(query.isNotEmpty) {
        var result = await booksRepository.fetchBooksByQuery(query,orderBy: DataUtils.getBookFilterStringFromEnum(BookFilterCategories.relevance));
        result.fold((l) {
          return left(l);
        }, (r) {
          bookList = r.items;
          bookDataMap.putIfAbsent(query, () => bookList);
        });
      }
    }
    return right(bookList);
  }

  setSelectedBookListItem(BookListItem item){
    selectedBookListItem = item;
    notifyListeners();
  }
}
