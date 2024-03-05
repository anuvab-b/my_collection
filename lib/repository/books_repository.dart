import 'package:dartz/dartz.dart';
import 'package:my_collection/data/network/api_endpoints.dart';
import 'package:my_collection/data/network/network.dart';
import 'package:my_collection/domain/i_books_repository.dart';
import 'package:my_collection/models/books/google_books_api_response_model.dart';
import 'package:my_collection/models/books/google_books_detail_response_model.dart';

class BooksRepository implements IBooksRepository{
  final ApiHelper apiHelper;
  BooksRepository({required this.apiHelper});
  @override
  Future<Either<String, GoogleBooksApiResponseModel>> fetchBooksByQuery(
      String query,
      {required String orderBy,
      int startIndex = 0,
      int maxResults = 20}) async {
    GoogleBooksApiResponseModel bookApiResponseModel;
    String url =
        "${ApiEndpoints.booksBaseUrl}?q=$query&key=${ApiEndpoints.booksApiKey}&orderBy=$orderBy&startIndex=$startIndex&maxResults=$maxResults";

    try {
      var res = await apiHelper.request(url: url, method: HTTPMETHOD.GET);
      if (res.statusCode == 200) {
        bookApiResponseModel = GoogleBooksApiResponseModel.fromJson(res.data);
        return right(bookApiResponseModel);
      } else {
        return left(res.message ?? "");
      }
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, GoogleBooksDetailResponseModel>> fetchBookByVolumeId(
      String volumeId) async {
    GoogleBooksDetailResponseModel googleBooksDetailResponseModel;
    String url = "${ApiEndpoints.booksBaseUrl}/$volumeId";
    try {
      var res = await apiHelper.request(url: url, method: HTTPMETHOD.GET);
      if (res.statusCode == 200) {
        googleBooksDetailResponseModel =
            GoogleBooksDetailResponseModel.fromJson(res.data);
        return right(googleBooksDetailResponseModel);
      } else {
        return left(res.message ?? "");
      }
    } catch (e) {
      return left(e.toString());
    }
  }
}
