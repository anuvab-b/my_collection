import 'package:jiffy/jiffy.dart';
import 'package:my_collection/viewmodel/books_provider.dart';
import 'package:my_collection/viewmodel/music_provider.dart';

class DataUtils {
  static String imagePlaceholderUrl =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/310px-Placeholder_view_vector.svg.png";

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

  static String getMusicSearchFilterCategoryFromEnum(
      MusicSearchCategories category) {
    switch (category) {
      case MusicSearchCategories.artist:
        return "artist";
      case MusicSearchCategories.album:
        return "album";
      case MusicSearchCategories.audiobook:
        return "audiobook";
      case MusicSearchCategories.episode:
        return "episode";
      case MusicSearchCategories.playlist:
        return "playlist";
      case MusicSearchCategories.show:
        return "show";
      case MusicSearchCategories.track:
        return "track";
      default:
        return "";
    }
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

  static String formatTrackType(String type){
    switch(type){
      case "track":
        return "Song";
      case "album":
        return "Album";
      case "artist":
        return "Artist";
      case "playlist":
        return "Playlist";
      default:
        return "";
    }
  }

  static String getAuthorNamesStringFromList(List<String>? names) {
    if (names == null || names.isEmpty) {
      return "";
    } else if (names.length < 2) {
      return names.first;
    } else if (names.length >= 2) {
      String str = "";
      for (var name in names) {
        str += "$name, ";
      }
      return str.substring(0, str.length - 2);
    }
    return "";
  }
}
