import 'package:dartz/dartz.dart';
import 'package:my_collection/models/books/google_books_api_response_model.dart';
import 'package:my_collection/models/books/google_books_detail_response_model.dart';

abstract class IBooksRepository{
  Future<Either<String, GoogleBooksApiResponseModel>> fetchBooksByQuery(
      String query,
      {required String orderBy,
        int startIndex = 0,
        int maxResults = 20});
  Future<Either<String, GoogleBooksDetailResponseModel>> fetchBookByVolumeId(
      String volumeId);
}