import 'package:jiffy/jiffy.dart';
import 'package:my_collection/viewmodel/books_provider.dart';

class DataUtils {
  static String getBookCategoryStringFromEnum(BookCategories category) {
    switch (category) {
      case BookCategories.selfImprovement:
        return "Self Improvement";
      case BookCategories.finance:
        return "Finance";
      case BookCategories.crime:
        return "Crime";
      case BookCategories.psychology:
        return "Psychology";
      default:
        return "";
    }
  }

  static String getBookFilterStringFromEnum(
      BookFilterCategories filterCategories) {
    return filterCategories == BookFilterCategories.newest
        ? "Newest"
        : "Relevance";
  }

  static String formatDate(String date,
      {String outputFormat = "dd/MM/yyyy", String inputFormat = "yyyy-MM-dd"}) {
    try {
      if (date.isNotEmpty) {
        return Jiffy.parse(date, pattern: inputFormat)
            .format(pattern: outputFormat);
      } else {
        return "-";
      }
    } catch (e) {
      return "-";
    }
  }
}
