import 'package:dio/dio.dart';
import 'package:my_collection/data/network/response.dart';
import 'package:my_collection/res/strings.dart';

class ErrorHandler {
  static response(DioException exception) {
    try {
      switch (exception.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return ApiResponse(success: false, message: AppStrings.timeOut);
        case DioExceptionType.badResponse:
          switch (exception.response?.statusCode) {
            case 400:
              String message = "Bad Request";
              if (exception.response?.data is Map &&
                  exception.response?.data["error"] is Map) {
                message =
                    "${exception.response?.statusMessage} : ${exception.response?.data["error"]["message"]}";
              }
              return ApiResponse(
                  success: false,
                  message: message,
                  data: exception.response?.data,
                  statusCode: 400);
            case 401:
              String message = "Unauthorized";
              if (exception.response?.data is Map &&
                  exception.response?.data["error"] is Map) {
                message =
                    "${exception.response?.statusMessage} : ${exception.response?.data["error"]["message"]}";
              }
              return ApiResponse(
                  success: false,
                  message: message,
                  data: exception.response?.data,
                  statusCode: 401);
            case 404:
              return ApiResponse(
                  success: false, message: AppStrings.timeOut, statusCode: 404);
            case 417:
              return ApiResponse(
                  success: false, message: AppStrings.timeOut, statusCode: 417);
            case 500:
              return ApiResponse(
                  success: false, message: AppStrings.timeOut, statusCode: 500);
            default:
              return ApiResponse(
                  success: false, message: AppStrings.unknownError);
          }
        case DioExceptionType.cancel:
          return ApiResponse(success: false, message: AppStrings.timeOut);

        case DioExceptionType.unknown:
          return ApiResponse(success: false, message: AppStrings.unknownError);
        default:
          return ApiResponse(success: false, message: AppStrings.unknownError);
      }
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }
}
