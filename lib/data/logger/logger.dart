import 'package:flutter/cupertino.dart';

class Logger{
  static void writeLog(String text){
    Future.microtask(() => debugPrint(text));
  }

  static void writeLongLog(String text){
    if (text.isEmpty) return;
    const int n = 1000;
    int startIndex = 0;
    int endIndex = n;
    while (startIndex < text.length) {
      if (endIndex > text.length) endIndex = text.length;
      debugPrint(text.substring(startIndex, endIndex));
      startIndex += n;
      endIndex = startIndex + n;
    }
  }
}