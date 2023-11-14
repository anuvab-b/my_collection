import 'package:flutter/material.dart';
import 'package:my_collection/models/books/google_books_api_response_model.dart';
import 'package:my_collection/utils/data_utils.dart';
import 'package:my_collection/viewmodel/books/books_repository.dart';

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

  GoogleBooksApiResponseModel booksOnSelfImprovement =
      GoogleBooksApiResponseModel(
          kind: "books#volumes", totalItems: 0, items: []);
  GoogleBooksApiResponseModel booksOnFinance = GoogleBooksApiResponseModel(
      kind: "books#volumes", totalItems: 0, items: []);
  GoogleBooksApiResponseModel booksOnPsychology = GoogleBooksApiResponseModel(
      kind: "books#volumes", totalItems: 0, items: []);
  GoogleBooksApiResponseModel booksOnCrime = GoogleBooksApiResponseModel(
      kind: "books#volumes", totalItems: 0, items: []);

  BookFilterCategories filterCategory = BookFilterCategories.newest;

  bool isSelfImpLoading = false;
  bool isFinanceLoading = false;
  bool isPsychologyLoading = false;
  bool isCrimeLoading = false;

  Future<void> getBooksOnSelfImprovement() async {
    isSelfImpLoading = true;
    notifyListeners();
    var result = await booksRepository.fetchBooksByQuery(
        DataUtils.getBookCategoryStringFromEnum(BookCategories.selfImprovement),
        orderBy: DataUtils.getBookFilterStringFromEnum(filterCategory));
    isSelfImpLoading = false;
    result.fold((l) {}, (r) {
      booksOnSelfImprovement = r;
    });
    notifyListeners();
  }

  Future<void> getBooksOnFinance() async {
    isFinanceLoading = true;
    notifyListeners();
    var result = await booksRepository.fetchBooksByQuery(
        DataUtils.getBookCategoryStringFromEnum(BookCategories.finance),
        orderBy: DataUtils.getBookFilterStringFromEnum(filterCategory));
    isFinanceLoading = false;
    result.fold((l) {}, (r) {
      booksOnFinance = r;
    });
    notifyListeners();
  }

  Future<void> getBooksOnPsychology() async {
    isPsychologyLoading = true;
    notifyListeners();
    var result = await booksRepository.fetchBooksByQuery(
        DataUtils.getBookCategoryStringFromEnum(BookCategories.psychology),
        orderBy: DataUtils.getBookFilterStringFromEnum(filterCategory));
    isPsychologyLoading = false;
    result.fold((l) {}, (r) {
      booksOnPsychology = r;
    });
    notifyListeners();
  }

  Future<void> getBooksOnCrime() async {
    isCrimeLoading = true;
    notifyListeners();
    var result = await booksRepository.fetchBooksByQuery(
        DataUtils.getBookCategoryStringFromEnum(BookCategories.crime),
        orderBy: DataUtils.getBookFilterStringFromEnum(filterCategory));
    isCrimeLoading = false;
    result.fold((l) {}, (r) {
      booksOnCrime = r;
    });
    notifyListeners();
  }
}
