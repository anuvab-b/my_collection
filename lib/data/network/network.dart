
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_collection/data/logger/logger.dart';
import 'package:my_collection/data/network/error.dart';
import 'package:my_collection/data/network/response.dart';

enum HTTPMETHOD { GET, POST, PUT, DELETE}

class ApiHelper extends ChangeNotifier{
  static BaseOptions baseOptions = BaseOptions(
      responseType: ResponseType.json
  );

  static Dio createDio() {
    return Dio(baseOptions);
  }

  static Dio addInterceptors(Dio dio) {
    dio.interceptors.add(HeaderInterceptor());
    dio.interceptors.add(LoggingInterceptor());
    return dio;
  }

  static final dio = createDio();
  static final Dio baseAPI = addInterceptors(dio);

  Future<ApiResponse> request({
    required String url, dynamic data, Map<String,dynamic> headers = const {}, HTTPMETHOD method = HTTPMETHOD.GET})async {
    late Response response;
    try {
      if (!await checkInternetConnectivity()) {
        return ApiResponse(
            success: false, message: "Internet Error", data: null);
      }

      switch (method) {
        case HTTPMETHOD.GET:
          response = await baseAPI.get(url, options: Options(headers: headers));
          break;
        case HTTPMETHOD.POST:
          response = await baseAPI.post(url, data: data);
          break;
        default:
      }
    final responseMessage = response.data;
    final responseData = response.data;
    return ApiResponse(
        success: true, message: responseMessage, data: responseData);
    } on DioException catch(e){
      return ErrorHandler.response(e);
    }
  }

  Future<bool> checkInternetConnectivity()async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    var result = false;
    switch(connectivityResult){
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        result = true;
        break;
      case ConnectivityResult.none:
        result = false;
        break;
      default :
        result = false;
    }
    return result;
  }
}

class HeaderInterceptor extends Interceptor{

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
    return super.onRequest(options, handler);
  }
}
class LoggingInterceptor extends Interceptor{
  int maxCharactersPerLine = 200;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Logger.writeLog("--> ${options.method} ${options.path}");
    Logger.writeLog("Content type: ${options.contentType}");
    Logger.writeLog("<-- END HTTP");
    return super.onRequest(options, handler);

  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Logger.writeLog("<-- ERROR -->");
    Logger.writeLog("${err.error.toString()} ==> ${err.requestOptions.uri.path.toString()}");
    Logger.writeLog(err.message.toString());
    return super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    String responseAsString = response.data.toString();
    Logger.writeLog("<-- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}");

    if(responseAsString.length > maxCharactersPerLine){
      Logger.writeLongLog(responseAsString);
    }
    else{
      Logger.writeLog(response.data.toString());
    }
    Logger.writeLog("<-- END HTTP");
    return super.onResponse(response, handler);

  }
}