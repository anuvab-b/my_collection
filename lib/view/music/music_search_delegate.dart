import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_collection/models/music/spotify_search_response_model.dart'
    as spotify;
import 'package:my_collection/utils/data_utils.dart';
import 'package:my_collection/utils/routes/route_names.dart';
import 'package:my_collection/view/music/playlists/playlist_list_view.dart';
import 'package:my_collection/view/widgets/common_loader.dart';
import 'package:my_collection/view/widgets/common_network_image.dart';
import 'package:my_collection/viewmodel/music_provider.dart';
import 'package:my_collection/viewmodel/playlist_provider.dart';
import 'package:provider/provider.dart';

class MusicSearchDelegate extends SearchDelegate {
  BuildContext buildContext;

  MusicSearchDelegate({required this.buildContext});

  @override
  String get searchFieldLabel => "What do you want to listen to?";

  @override
  TextStyle get searchFieldStyle => TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w200,
      fontFamily: "Poppins",
      color: Theme.of(buildContext).primaryColorLight);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          final musicProvider =
              Provider.of<MusicProvider>(context, listen: false);
          musicProvider.onSearchQueryChanged(query);
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer<MusicProvider>(builder: (context, provider, child) {
      return Container(
        margin: const EdgeInsets.all(16),
        child: FutureBuilder(
            future: provider.getMusicBySearch(
                query,
                DataUtils.getMusicSearchFilterCategoryFromEnum(
                    provider.selectedFilterCategory)),
            builder: (BuildContext context,
                AsyncSnapshot<
                        Either<String, spotify.SpotifySearchResponseModel>?>
                    snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CupertinoActivityIndicator();
              } else if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                var result = snapshot.data;
                spotify.SpotifySearchResponseModel? searchResponseModel;
                String? message;
                result!.fold((l) {
                  message = l;
                }, (r) {
                  searchResponseModel = r;
                });
                if (message != null) {
                  return Center(
                      child: Text(message ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: Theme.of(context).primaryColorLight)));
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                searchResponseModel?.tracks?.items.length,
                            itemBuilder: (ctx, index) {
                              spotify.TracksItem? trackItem =
                                  searchResponseModel?.tracks?.items[index];
                              return Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(4, 8, 4, 8),
                                  child: Row(children: [
                                    SizedBox(
                                        height: 48,
                                        width: 48,
                                        child: (trackItem != null &&
                                                trackItem.album != null &&
                                                trackItem
                                                    .album!.images.isNotEmpty)
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.fill,
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              progress) =>
                                                          Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      value: progress.progress,
                                                      color: Theme.of(context)
                                                          .primaryColorLight,
                                                    ),
                                                  ),
                                                  imageUrl:
                                                      "${trackItem?.album?.images.first.url}",
                                                ),
                                              )
                                            : const CommonPlaceholderNetworkImage()),
                                    const SizedBox(width: 8.0),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(trackItem?.name ?? "",
                                              maxLines: 1,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Theme.of(context)
                                                      .highlightColor)),
                                          const SizedBox(height: 4.0),
                                          Row(children: [
                                            Text(
                                                DataUtils.formatTrackType(
                                                    trackItem?.type ?? ""),
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Theme.of(context)
                                                        .primaryColorLight)),
                                            const SizedBox(width: 4.0),
                                            const Icon(Icons.circle, size: 4.0),
                                            const SizedBox(width: 4.0),
                                            Flexible(
                                              child: Text(
                                                  trackItem?.artists
                                                          .map((e) => e.name)
                                                          .toList()
                                                          ?.join(',') ??
                                                      "",
                                                  maxLines: 1,
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Theme.of(context)
                                                          .primaryColorLight)),
                                            ),
                                          ])
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                        child: const Icon(Icons.more_vert),
                                        onTap: () {
                                          showModalBottomSheet(
                                              // Set this when inner content overflows, making RoundedRectangleBorder not working as expected
                                              clipBehavior: Clip.antiAlias,
                                              // Set shape to make top corners rounded
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(16),
                                                  topRight: Radius.circular(16),
                                                ),
                                              ),
                                              enableDrag: true,
                                              // isScrollControlled: true,
                                              context: context,
                                              builder: (context) {
                                                return Consumer<
                                                        PlayListProvider>(
                                                    builder: (context, provider,
                                                        child) {
                                                  return Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16.0,
                                                          vertical: 16.0),
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                              "Add to a Playlist",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize:
                                                                      24)),
                                                          Expanded(child:
                                                              PlayListListView(
                                                                  onTap:
                                                                      (_) async {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                barrierDismissible:
                                                                    false,
                                                                barrierColor: Colors
                                                                    .transparent,
                                                                builder: (ctx) {
                                                                  return const CommonLoader();
                                                                });
                                                            await provider
                                                                .addNewSongToPlayList(
                                                                    trackItem!,
                                                                    _);
                                                            if (context
                                                                .mounted) {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            }
                                                          })),
                                                        ],
                                                      ));
                                                });
                                              });
                                        })
                                  ]));
                            }),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                searchResponseModel?.albums?.items.length,
                            itemBuilder: (ctx, index) {
                              spotify.AlbumElement? albumElement =
                                  searchResponseModel?.albums?.items[index];
                              return Container(
                                padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                                child: Row(
                                  children: [
                                    SizedBox(
                                        height: 48,
                                        width: 48,
                                        child: (albumElement != null &&
                                                albumElement.images.isNotEmpty)
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.fill,
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              progress) =>
                                                          Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      value: progress.progress,
                                                      color: Theme.of(context)
                                                          .primaryColorLight,
                                                    ),
                                                  ),
                                                  imageUrl:
                                                      "${albumElement?.images.first.url}",
                                                ),
                                              )
                                            : const CommonPlaceholderNetworkImage()),
                                    const SizedBox(width: 8.0),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(albumElement?.name ?? "",
                                              maxLines: 1,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Theme.of(context)
                                                      .highlightColor)),
                                          const SizedBox(height: 4.0),
                                          Row(children: [
                                            Text(
                                                DataUtils.formatTrackType(
                                                    albumElement?.type ?? ""),
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Theme.of(context)
                                                        .primaryColorLight)),
                                            const SizedBox(width: 4.0),
                                            const Icon(Icons.circle, size: 4.0),
                                            const SizedBox(width: 4.0),
                                            Flexible(
                                              child: Text(
                                                  albumElement?.artists
                                                          .map((e) => e.name)
                                                          .toList()
                                                          ?.join(',') ??
                                                      "",
                                                  maxLines: 1,
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Theme.of(context)
                                                          .primaryColorLight)),
                                            ),
                                          ])
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                searchResponseModel?.artists?.items.length,
                            itemBuilder: (ctx, index) {
                              spotify.ArtistsItem? artistItem =
                                  searchResponseModel?.artists?.items[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RouteNames.artistScreen,
                                      arguments: {
                                        "artistId": artistItem?.id ?? ""
                                      });
                                  Provider.of<MusicProvider>(context,
                                          listen: false)
                                      .getArtistDetails(artistItem?.id ?? "");
                                  Provider.of<MusicProvider>(context,
                                          listen: false)
                                      .getArtistAlbums(artistItem?.id ?? "");
                                  Provider.of<MusicProvider>(context,
                                          listen: false)
                                      .getSpotifyArtistTopTracks(
                                          artistItem?.id ?? "");
                                  Provider.of<MusicProvider>(context,
                                          listen: false)
                                      .getSpotifyArtistRelatedArtists(
                                          artistItem?.id ?? "");
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(4, 8, 4, 8),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          height: 48,
                                          width: 48,
                                          child: (artistItem != null &&
                                                  artistItem.images.isNotEmpty)
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.fill,
                                                    progressIndicatorBuilder:
                                                        (context, url,
                                                                progress) =>
                                                            Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        value:
                                                            progress.progress,
                                                        color: Theme.of(context)
                                                            .primaryColorLight,
                                                      ),
                                                    ),
                                                    imageUrl:
                                                        "${artistItem.images.first.url}",
                                                  ),
                                                )
                                              : const CommonPlaceholderNetworkImage()),
                                      const SizedBox(width: 8.0),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(artistItem?.name ?? "",
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Theme.of(context)
                                                        .highlightColor)),
                                            const SizedBox(height: 4.0),
                                            Row(children: [
                                              Text(
                                                  DataUtils.formatTrackType(
                                                      artistItem?.type ?? ""),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Theme.of(context)
                                                          .primaryColorLight)),
                                              const SizedBox(width: 4.0),
                                              const Icon(Icons.circle,
                                                  size: 4.0),
                                              const SizedBox(width: 4.0),
                                              Flexible(
                                                child: Text(
                                                    artistItem?.name ?? "",
                                                    maxLines: 1,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Theme.of(context)
                                                            .primaryColorLight)),
                                              ),
                                            ])
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                searchResponseModel?.playlists?.items.length,
                            itemBuilder: (ctx, index) {
                              spotify.PlaylistsItem? playListItem =
                                  searchResponseModel?.playlists?.items[index];
                              return Container(
                                padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                                child: Row(
                                  children: [
                                    SizedBox(
                                        height: 48,
                                        width: 48,
                                        child: (playListItem != null &&
                                                playListItem.images.isNotEmpty)
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.fill,
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              progress) =>
                                                          Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      value: progress.progress,
                                                      color: Theme.of(context)
                                                          .primaryColorLight,
                                                    ),
                                                  ),
                                                  imageUrl:
                                                      "${playListItem.images.first.url}",
                                                ),
                                              )
                                            : const CommonPlaceholderNetworkImage()),
                                    const SizedBox(width: 8.0),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(playListItem?.name ?? "",
                                              maxLines: 1,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Theme.of(context)
                                                      .highlightColor)),
                                          const SizedBox(height: 4.0),
                                          Row(children: [
                                            Text(
                                                DataUtils.formatTrackType(
                                                    playListItem?.type ?? ""),
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Theme.of(context)
                                                        .primaryColorLight)),
                                          ])
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  );
                }
              } else {
                return const SizedBox();
              }
            }),
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Play what you love",
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Theme.of(context).primaryColorLight,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Poppins")),
          const SizedBox(height: 8.0),
          Text("Search for artists, songs, podcasts and more.",
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Theme.of(context).primaryColorLight,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w300,
                  fontFamily: "Poppins")),
        ],
      ),
    );
  }
}
