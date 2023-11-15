import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_collection/models/music/spotify_search_response_model.dart'
    as spotify;
import 'package:my_collection/repository/music_repository.dart';
import 'package:my_collection/utils/data_utils.dart';
import 'package:my_collection/viewmodel/music_provider.dart';
import 'package:provider/provider.dart';

class MusicSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
// this will show clear query button
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
// adding a back button to close the search
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
                                padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                                child: Row(
                                  children: [
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
                                                    ),
                                                  ),
                                                  imageUrl:
                                                      "${trackItem?.album?.images.first.url}",
                                                ),
                                              )
                                            : Image.network(
                                                "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/310px-Placeholder_view_vector.svg.png",
                                                fit: BoxFit.fill)),
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
                                            Text(trackItem?.type ?? "",
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
                                  ],
                                ),
                              );
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
                                                    ),
                                                  ),
                                                  imageUrl:
                                                      "${albumElement?.images.first.url}",
                                                ),
                                              )
                                            : Image.network(
                                                "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/310px-Placeholder_view_vector.svg.png",
                                                fit: BoxFit.fill)),
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
                                            Text(albumElement?.type ?? "",
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
                              return Container(
                                padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                                child: Row(
                                  children: [
                                    SizedBox(
                                        height: 48,
                                        width: 48,
                                        child: (artistItem != null &&
                                                artistItem.images.isNotEmpty)
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
                                                    ),
                                                  ),
                                                  imageUrl:
                                                      "${artistItem.images.first.url}",
                                                ),
                                              )
                                            : Image.network(
                                                "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/310px-Placeholder_view_vector.svg.png",
                                                fit: BoxFit.fill)),
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
                                            Text(artistItem?.type ?? "",
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
                                                    ),
                                                  ),
                                                  imageUrl:
                                                      "${playListItem.images.first.url}",
                                                ),
                                              )
                                            : Image.network(
                                                "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/310px-Placeholder_view_vector.svg.png",
                                                fit: BoxFit.fill)),
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
                                            Text(playListItem?.type ?? "",
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
    return const SizedBox();
  }
}
