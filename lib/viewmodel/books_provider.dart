import 'package:flutter/material.dart';
import 'package:my_collection/models/books/google_books_api_response_model.dart';
import 'package:my_collection/utils/data_utils.dart';
import 'package:my_collection/repository/books_repository.dart';

enum BookCategories {
  selfImprovement,
  finance,
  psychology,
  personalityDevelopment,
  selfLove,
  selfHelp,
  crime,
  thriller,
  communicationSkills,
  romance
}

enum BookFilterCategories { relevance, newest }

class BooksProvider extends ChangeNotifier {
  BooksRepository booksRepository = BooksRepository();

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
      var result = await booksRepository.fetchBooksByQuery(bookCategory,
          orderBy: DataUtils.getBookFilterStringFromEnum(filterCategory));
      isSelfImpLoading = false;
      result.fold((l) {}, (r) {
        booksOnSelfImprovement = r.items;
        bookDataMap.putIfAbsent(bookCategory, () => booksOnSelfImprovement);
      });
    }
    notifyListeners();
  }

  Future<void> getBooksOnFinance() async {
    String bookCategory = DataUtils.getBookCategoryStringFromEnum(BookCategories.finance);

    if(bookDataMap.containsKey(bookCategory)){
      booksOnFinance = bookDataMap[bookCategory]!;
    }
    else {
      isFinanceLoading = true;
      notifyListeners();
      var result = await booksRepository.fetchBooksByQuery(
          bookCategory,
          orderBy: DataUtils.getBookFilterStringFromEnum(filterCategory));
      isFinanceLoading = false;
      result.fold((l) {}, (r) {
        booksOnFinance = r.items;
        bookDataMap.putIfAbsent(bookCategory, () => booksOnFinance);

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
      var result = await booksRepository.fetchBooksByQuery(
          bookCategory,
          orderBy: DataUtils.getBookFilterStringFromEnum(filterCategory));
      isPsychologyLoading = false;
      result.fold((l) {}, (r) {
        booksOnPsychology = r.items;
        bookDataMap.putIfAbsent(bookCategory, () => booksOnPsychology);
      });
    }
    notifyListeners();
  }

  Future<void> getBooksOnCrime() async {
    String bookCategory = DataUtils.getBookCategoryStringFromEnum(BookCategories.crime);

    if(bookDataMap.containsKey(bookCategory)){
      booksOnPsychology = bookDataMap[bookCategory]!;
    }
    else {
      isCrimeLoading = true;
      notifyListeners();
      var result = await booksRepository.fetchBooksByQuery(
          bookCategory,
          orderBy: DataUtils.getBookFilterStringFromEnum(filterCategory));
      isCrimeLoading = false;
      result.fold((l) {}, (r) {
        booksOnCrime = r.items;
        bookDataMap.putIfAbsent(bookCategory, () => booksOnCrime);
      });
    }
    notifyListeners();
  }
}
