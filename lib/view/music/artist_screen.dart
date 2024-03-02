import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_collection/models/music/artists/spotify_artist_albums.dart';
import 'package:my_collection/models/music/artists/spotify_artist_related_artists.dart';
import 'package:my_collection/models/music/artists/spotify_artist_top_tracks.dart';
import 'package:my_collection/view/widgets/common_network_image.dart';
import 'package:my_collection/viewmodel/music_provider.dart';
import 'package:provider/provider.dart';

class ArtistScreen extends StatelessWidget {
  const ArtistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Consumer<MusicProvider>(builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                provider.isArtistDetailsLoading
                    ? const Center(child: CupertinoActivityIndicator())
                    : provider.artistDetailsErrorMessage.isNotEmpty
                        ? Center(
                            child: Text(
                                provider.artistDetailsErrorMessage ?? "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                    color:
                                        Theme.of(context).primaryColorLight)))
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (provider
                                  .spotifyArtistDetails!.images.isNotEmpty)
                                Stack(
                                  children: [
                                    CachedNetworkImage(
                                        height: 400,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.fill,
                                        progressIndicatorBuilder: (context, url,
                                                progress) =>
                                            Center(
                                              child: CircularProgressIndicator(
                                                value: progress.progress,
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                              ),
                                            ),
                                        imageUrl: provider.spotifyArtistDetails!
                                                .images.first.url ??
                                            ""),
                                    Positioned.fill(
                                        child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0,
                                                        vertical: 8.0),
                                                child: Text(
                                                  provider.spotifyArtistDetails!
                                                          .name ??
                                                      "",
                                                  style: const TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 32,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                )))),
                                  ],
                                ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 24.0),
                                    Text(
                                      "${provider.spotifyArtistDetails!.followers?.total ?? "-"} Followers",
                                      style: const TextStyle(
                                          fontFamily: "Poppins"),
                                    ),
                                    const SizedBox(height: 24.0),
                                    SizedBox(
                                      height: 40,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: provider
                                              .spotifyArtistDetails!
                                              .genres
                                              .length,
                                          itemBuilder: (ctx, index) {
                                            return Container(
                                              margin: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Chip(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .primaryColor,
                                                shadowColor: Theme.of(context)
                                                    .primaryColorLight,
                                                label: Text(
                                                  provider.spotifyArtistDetails!
                                                      .genres[index],
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ), //Text
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                provider.isArtistAlbumsLoading
                    ? const Center(child: CupertinoActivityIndicator())
                    : provider.artistAlbumsErrorMessage.isNotEmpty
                        ? Center(
                            child: Text(provider.artistAlbumsErrorMessage ?? "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                    color:
                                        Theme.of(context).primaryColorLight)))
                        : Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Albums",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24.0,
                                        fontFamily: "Poppins")),
                                ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: provider.spotifyArtistAlbums!
                                                .items.length >
                                            5
                                        ? 5
                                        : provider
                                            .spotifyArtistAlbums!.items.length,
                                    itemBuilder: (ctx, index) {
                                      Item item = provider
                                          .spotifyArtistAlbums!.items[index];
                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            CachedNetworkImage(
                                                height: 80,
                                                width: 80,
                                                fit: BoxFit.fill,
                                                progressIndicatorBuilder:
                                                    (context, url, progress) =>
                                                        Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            value: progress
                                                                .progress,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColorLight,
                                                          ),
                                                        ),
                                                imageUrl:
                                                    item.images.first.url ??
                                                        ""),
                                            const SizedBox(width: 16.0),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item.name ?? "",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontFamily: "Poppins",
                                                        fontSize: 16),
                                                  ),
                                                  Text(
                                                      item.releaseDate
                                                              ?.substring(
                                                                  0, 4) ??
                                                          "",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          fontSize: 14,
                                                          fontFamily:
                                                              "Poppins")),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          ),
                provider.isArtistTopTracksLoading
                    ? const SizedBox()
                    : (provider.artistTopTracksErrorMessage.isEmpty &&
                            provider.spotifyArtistTopTracks != null)
                        ? Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Top Tracks",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24.0,
                                        fontFamily: "Poppins")),
                                ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: provider.spotifyArtistTopTracks!
                                                .tracks.length >
                                            5
                                        ? 5
                                        : provider.spotifyArtistTopTracks!
                                            .tracks.length,
                                    itemBuilder: (ctx, index) {
                                      Track track = provider
                                          .spotifyArtistTopTracks!
                                          .tracks[index];
                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            (track.album != null &&
                                                    track.album!.images
                                                        .isNotEmpty)
                                                ? CachedNetworkImage(
                                                    height: 80,
                                                    width: 80,
                                                    fit: BoxFit.fill,
                                                    progressIndicatorBuilder:
                                                        (context, url,
                                                                progress) =>
                                                            Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                value: progress
                                                                    .progress,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColorLight,
                                                              ),
                                                            ),
                                                    imageUrl: track
                                                            .album
                                                            ?.images
                                                            .first
                                                            .url ??
                                                        "")
                                                : const CommonPlaceholderNetworkImage(),
                                            const SizedBox(width: 16.0),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    track.name ?? "",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontFamily: "Poppins",
                                                        fontSize: 16),
                                                  ),
                                                  Text(
                                                      track.album?.releaseDate
                                                              ?.substring(
                                                                  0, 4) ??
                                                          "",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          fontSize: 14,
                                                          fontFamily:
                                                              "Poppins")),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          )
                        : const SizedBox(),
                provider.isArtistRelatedArtistsLoading
                    ? const SizedBox()
                    : (provider.artistRelatedArtistsErrorMessage.isEmpty &&
                            provider.spotifyArtistRelatedArtists != null)
                        ? Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Related Artists",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24.0,
                                        fontFamily: "Poppins")),
                                SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: provider
                                                  .spotifyArtistRelatedArtists!
                                                  .artists
                                                  .length,
                                      itemBuilder: (ctx, index) {
                                        Artist artist = provider
                                            .spotifyArtistRelatedArtists!
                                            .artists[index];
                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 4.0, horizontal: 8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              (artist.images.isNotEmpty)
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      child: CachedNetworkImage(
                                                          height: 160,
                                                          width: 160,
                                                          fit: BoxFit.fill,
                                                          progressIndicatorBuilder:
                                                              (context, url,
                                                                      progress) =>
                                                                  Center(
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      value: progress
                                                                          .progress,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColorLight,
                                                                    ),
                                                                  ),
                                                          imageUrl: artist
                                                                  .images
                                                                  .first
                                                                  .url ??
                                                              ""))
                                                  : const CommonPlaceholderNetworkImage(),
                                              const SizedBox(height: 8.0),
                                              Text(
                                                artist.name ?? "",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontFamily: "Poppins",
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
              ],
            ),
          );
        }));
  }
}
