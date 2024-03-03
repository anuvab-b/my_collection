import 'package:jiffy/jiffy.dart';

enum BookShelves{
  favorites,
  purchased,
  toRead,
  readingNow,
  haveRead
}
enum BookFilterCategories { relevance, newest }
enum BookCategories {
  selfImprovement,
  finance,
  psychology,
  personalityDevelopment,
  selfLove,
  selfHelp,
  crime,
  thriller,
  communicationSkills,
  romance
}
enum MovieWatchLists{
  favourites,
  reWatch,
  toWatch,
  watchingNow,
  haveWatched
}

enum SeriesWatchLists{
  favourites,
  reWatch,
  toWatch,
  watchingNow,
  haveWatched
}

enum MusicPlaylists{
  favourites
}
enum MusicSearchCategories {
  album,
  artist,
  playlist,
  track,
  show,
  episode,
  audiobook
}

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

  static String getBookshelfStringFromEnum(BookShelves bookshelf) {
    switch (bookshelf) {
      case BookShelves.favorites:
        return "Favourites";
      case BookShelves.purchased:
        return "Purchased";
      case BookShelves.toRead:
        return "To Read";
      case BookShelves.readingNow:
        return "Reading Now";
      case BookShelves.haveRead:
        return "Have Read";
      default:
        return "";
    }
  }

  static String getMovieWatchlistStringFromEnum(MovieWatchLists moviePlaylist) {
    switch (moviePlaylist) {
      case MovieWatchLists.favourites:
        return "Favourites";
      case MovieWatchLists.haveWatched:
        return "Have Watched";
      case MovieWatchLists.reWatch:
        return "Watch Again";
      case MovieWatchLists.toWatch:
        return "To Watch";
      case MovieWatchLists.watchingNow:
        return "Watching Now";
      default:
        return "";
    }
  }

  static String getSeriesWatchlistStringFromEnum(SeriesWatchLists seriesPlaylist) {
    switch (seriesPlaylist) {
      case SeriesWatchLists.favourites:
        return "Favourites";
      case SeriesWatchLists.haveWatched:
        return "Have Watched";
      case SeriesWatchLists.reWatch:
        return "Watch Again";
      case SeriesWatchLists.toWatch:
        return "To Watch";
      case SeriesWatchLists.watchingNow:
        return "Watching Now";
      default:
        return "";
    }
  }

  static String getMusicPlaylistStringFromEnum(MusicPlaylists musicPlaylist) {
    switch (musicPlaylist) {
      case MusicPlaylists.favourites:
        return "Favourites";
      default:
        return "";
    }
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

  static String formatTrackType(String type) {
    switch (type) {
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
