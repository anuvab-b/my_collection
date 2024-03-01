import 'package:jiffy/jiffy.dart';

class DateUtils{
  static DateTime? getDateTime(String dateTime){
    try{
      return Jiffy.parse(dateTime).dateTime;
    }
    catch(e){
      return null;
    }
  }
}