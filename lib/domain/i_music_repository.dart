import 'package:dartz/dartz.dart';
import 'package:my_collection/models/music/artists/spotify_artist_albums.dart';
import 'package:my_collection/models/music/artists/spotify_artist_details.dart';
import 'package:my_collection/models/music/artists/spotify_artist_related_artists.dart';
import 'package:my_collection/models/music/artists/spotify_artist_top_tracks.dart';
import 'package:my_collection/models/music/spotify_search_response_model.dart';

abstract class IMusicRepository{
  Future<Either<String, String>> getSpotifyToken();

  Future<Either<String, SpotifySearchResponseModel>> getSpotifySearchResults(
      String accessToken, String query, String queryType,
      {int offset = 0, int limit = 20});
  Future<Either<String, SpotifyArtistDetails>> getSpotifyArtistDetails(
      String artistId, String accessToken);

  Future<Either<String, SpotifyArtistAlbums>> getSpotifyArtistAlbums(
      String artistId, String accessToken);

  Future<Either<String, SpotifyArtistTopTracks>> getSpotifyArtistTopTracks(
      String artistId, String accessToken);

  Future<Either<String, SpotifyArtistRelatedArtists>> getSpotifyArtistRelatedArtists(
      String artistId, String accessToken);
}