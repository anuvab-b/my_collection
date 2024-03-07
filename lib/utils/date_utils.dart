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

  static String formatDateTime(DateTime? dateTime,
      {String outputFormat = "dd/MM/yyyy", String inputFormat = "yyyy-MM-dd"}) {
    try {
      if(dateTime!=null) {
        return Jiffy.parseFromDateTime(dateTime).format(pattern: outputFormat);
      }
      return "-";
    } catch (e) {
      return "-";
    }
  }
}