import 'package:dio/dio.dart';

class ErrorHandler{
  static response(DioException exception){
    switch(exception.type){
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
    }
  }
}