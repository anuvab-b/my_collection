import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_collection/data/network/api_endpoints.dart';
import 'package:my_collection/models/tv/tmdb_tv_response_model.dart';
import 'package:my_collection/utils/routes/route_names.dart';
import 'package:my_collection/view/series/series_watchlist_list_view.dart';
import 'package:my_collection/view/widgets/common_loader.dart';
import 'package:my_collection/view/widgets/common_network_image.dart';
import 'package:my_collection/viewmodel/series_provider.dart';
import 'package:my_collection/viewmodel/series_watchlist_provider.dart';
import 'package:provider/provider.dart';

class SeriesSearchDelegate extends SearchDelegate {
  BuildContext buildContext;

  SeriesSearchDelegate({required this.buildContext});

  @override
  String get searchFieldLabel => "What do you want to watch?";

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
          final seriesProvider =
              Provider.of<SeriesProvider>(context, listen: false);
          seriesProvider.onSearchQueryChanged(query);
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
    return Consumer<SeriesProvider>(builder: (context, provider, child) {
      return Container(
        margin: const EdgeInsets.all(16),
        child: FutureBuilder(
            future: provider.getSeriesBySearch(query),
            builder: (BuildContext context,
                AsyncSnapshot<Either<String, TmdbTvResponseModel>?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                var result = snapshot.data;
                TmdbTvResponseModel? searchResponseModel;
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
                            itemCount: searchResponseModel?.results.length,
                            itemBuilder: (ctx, index) {
                              SeriesListModel seriesListModel =
                                  searchResponseModel!.results[index];
                              return InkWell(
                                onTap: () {
                                  provider.setSelectedSeriesListItem(
                                      seriesListModel);
                                  provider.fetchSeriesAggCredits();
                                  provider.fetchSeriesDetails();
                                  Navigator.pushNamed(
                                      context, RouteNames.seriesDetailsScreen);
                                },
                                child: Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(4, 8, 4, 8),
                                    child: Row(children: [
                                      SizedBox(
                                          width: 60,
                                          height: 80,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: CachedNetworkImage(
                                              errorWidget:
                                                  (context, value, value2) {
                                                return const CommonPlaceholderNetworkImage();
                                              },
                                              fit: BoxFit.fill,
                                              progressIndicatorBuilder:
                                                  (context, url, progress) =>
                                                      Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Theme.of(context)
                                                      .primaryColorLight,
                                                  value: progress.progress,
                                                ),
                                              ),
                                              imageUrl:
                                                  "${ApiEndpoints.tmdbPosterPath}${seriesListModel.posterPath}",
                                            ),
                                          )),
                                      const SizedBox(width: 8.0),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(seriesListModel.name ?? "",
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Theme.of(context)
                                                        .highlightColor)),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                const Icon(Icons.star_rounded,
                                                    color: Colors.amber),
                                                const SizedBox(width: 2.0),
                                                Text(
                                                  seriesListModel.voteAverage
                                                          ?.toStringAsFixed(
                                                              1) ??
                                                      "",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: Theme.of(context)
                                                          .primaryColorLight,
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: "Poppins"),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4.0),
                                            if (seriesListModel
                                                    .firstAirDate?.year !=
                                                null)
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                child: Text(
                                                  "${seriesListModel.firstAirDate?.year}",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: Theme.of(context)
                                                          .primaryColorLight,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: "Poppins"),
                                                ),
                                              ),
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(16),
                                                    topRight:
                                                        Radius.circular(16),
                                                  ),
                                                ),
                                                enableDrag: true,
                                                // isScrollControlled: true,
                                                context: context,
                                                builder: (context) {
                                                  return Consumer<
                                                          SeriesWatchListProvider>(
                                                      builder: (context,
                                                          provider, child) {
                                                    return Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    16.0,
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
                                                                SeriesWatchListListView(
                                                                    onTap:
                                                                        (_) async {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  barrierDismissible:
                                                                      false,
                                                                  barrierColor:
                                                                      Colors
                                                                          .transparent,
                                                                  builder:
                                                                      (ctx) {
                                                                    return const CommonLoader();
                                                                  });
                                                              await provider
                                                                  .addNewSeriesToWatchList(
                                                                      seriesListModel,
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
                                    ])),
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
          Text("Watch what you love",
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Theme.of(context).primaryColorLight,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Poppins")),
          const SizedBox(height: 8.0),
          Text("Search for Series",
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
