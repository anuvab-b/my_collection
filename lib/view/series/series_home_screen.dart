import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_collection/data/network/api_endpoints.dart';
import 'package:my_collection/models/tv/tmdb_tv_response_model.dart';
import 'package:my_collection/utils/dimens.dart';
import 'package:my_collection/utils/routes/route_names.dart';
import 'package:my_collection/view/series/series_search_delegate.dart';
import 'package:my_collection/view/widgets/search_widget_container.dart';
import 'package:my_collection/view/widgets/shimmer_layout.dart';
import 'package:my_collection/viewmodel/series_provider.dart';
import 'package:my_collection/viewmodel/series_watchlist_provider.dart';
import 'package:provider/provider.dart';

class SeriesHomeScreen extends StatelessWidget {
  const SeriesHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SeriesProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            child: Column(
              children: [
                Consumer<SeriesWatchListProvider>(
                    builder: (context, watchListProvider, child) {
                  return watchListProvider.seriesWatchLists.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16.0),
                            Text(
                              "Your Watchlist collection",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: "Poppins"),
                            ),
                            SizedBox(
                                height: 180,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (ctx, index) {
                                      TmdbTvResponseModel moviePlaylistModel =
                                          watchListProvider
                                              .seriesWatchLists[index];
                                      return Container(
                                        margin:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Card(
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            width: 180,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                const Icon(Icons.movie),
                                                Text(
                                                    "${moviePlaylistModel.name}",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontFamily: "Poppins")),
                                                Text(
                                                    "${moviePlaylistModel.results.length} items",
                                                    style: const TextStyle(
                                                        fontFamily: "Poppins")),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: watchListProvider
                                        .seriesWatchLists.length)),
                          ],
                        )
                      : const SizedBox();
                }),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const SizedBox(height: 16.0),
                  provider.isNowPlayingLoading
                      ? ShimmerLayout(
                          layoutHeight: SeriesDimens.listItemHeight,
                          itemHeight: SeriesDimens.listItemHeight,
                          itemWidth: SeriesDimens.listItemWidth)
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: TextButton(
                                  onPressed: () async {
                                    Navigator.pushNamed(context,
                                        RouteNames.createSeriesWatchListForm);
                                  },
                                  style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      foregroundColor:
                                          Theme.of(context).primaryColorDark),
                                  child: Text(
                                    "Create a Watchlist",
                                    style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        fontSize: 18,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              // SizedBox(
                              //   height: MediaQuery.of(context).size.width * 0.6,
                              //   child: PageView(
                              //       clipBehavior: Clip.none,
                              //       controller: provider.pageController,
                              //       onPageChanged: (value) {
                              //         provider.storeIndex(value);
                              //       },
                              //       children: provider.airingTodaySeriesList
                              //           .map((e) => Container(
                              //                 padding:
                              //                     const EdgeInsets.symmetric(
                              //                         horizontal: 4.0,
                              //                         vertical: 4.0),
                              //                 margin:
                              //                     const EdgeInsets.symmetric(
                              //                         horizontal: 4.0,
                              //                         vertical: 4.0),
                              //                 child: Card(
                              //                   shadowColor: Colors.grey,
                              //                   child: Stack(
                              //                     children: [
                              //                       ClipRRect(
                              //                           borderRadius:
                              //                               BorderRadius
                              //                                   .circular(8),
                              //                           child: SizedBox(
                              //                             width: MediaQuery.of(
                              //                                     context)
                              //                                 .size
                              //                                 .width,
                              //                             child:
                              //                                 CachedNetworkImage(
                              //                               fit: BoxFit.fill,
                              //                               progressIndicatorBuilder:
                              //                                   (context, url,
                              //                                           progress) =>
                              //                                       Center(
                              //                                 child:
                              //                                     CircularProgressIndicator(
                              //                                   value: progress
                              //                                       .progress,
                              //                                   color: Theme.of(
                              //                                           context)
                              //                                       .primaryColorLight,
                              //                                 ),
                              //                               ),
                              //                               imageUrl:
                              //                                   "${ApiEndpoints.tmdbPosterPath}${e.posterPath}",
                              //                             ),
                              //                           )),
                              //                     ],
                              //                   ),
                              //                 ),
                              //               ))
                              //           .toList()),
                              // ),
                            ]),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: List<Widget>.generate(
                  //       provider.airingTodaySeriesList.length > 3
                  //           ? 3
                  //           : provider.airingTodaySeriesList.length,
                  //       (int index) {
                  //     return AnimatedContainer(
                  //       duration: const Duration(milliseconds: 300),
                  //       width: index == provider.selectedPageIndex ? 24.0 : 8.0,
                  //       height: 8.0,
                  //       margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(30.0),
                  //         // shape: BoxShape.circle,
                  //         color: index == provider.selectedPageIndex
                  //             ? Theme.of(context).highlightColor
                  //             : Theme.of(context).primaryColorLight,
                  //       ),
                  //     );
                  //   }),
                  // ),
                  const SizedBox(height: 16.0),
                  SearchWidgetContainer(
                      hintText: "Search",
                      onTap: () {
                        showSearch(
                          context: context,
                          delegate: SeriesSearchDelegate(buildContext: context),
                        );
                      }),
                  const SizedBox(height: 16.0),
                  provider.isAiringTodayLoading
                      ? ShimmerLayout(
                          layoutHeight: SeriesDimens.listItemHeight,
                          itemHeight: SeriesDimens.listItemHeight,
                          itemWidth: SeriesDimens.listItemWidth)
                      : HorizontalSeriesPosterListViewSection(
                          seriesList: provider.airingTodaySeriesList,
                          sectionHeader: "Airing Today"),
                  const SizedBox(height: 16.0),
                  provider.isOnTheAirLoading
                      ? ShimmerLayout(
                          layoutHeight: SeriesDimens.listItemHeight,
                          itemHeight: SeriesDimens.listItemHeight,
                          itemWidth: SeriesDimens.listItemWidth)
                      : HorizontalSeriesPosterListViewSection(
                          seriesList: provider.onTheAirSeriesList,
                          sectionHeader: "On The Air"),
                  const SizedBox(height: 16.0),
                  provider.isPopularLoading
                      ? ShimmerLayout(
                          layoutHeight: SeriesDimens.listItemHeight,
                          itemHeight: SeriesDimens.listItemHeight,
                          itemWidth: SeriesDimens.listItemWidth)
                      : HorizontalSeriesPosterListViewSection(
                          seriesList: provider.popularSeriesList,
                          sectionHeader: "Popular"),
                  const SizedBox(height: 16.0),
                  provider.isTopRatedLoading
                      ? ShimmerLayout(
                          layoutHeight: SeriesDimens.listItemHeight,
                          itemHeight: SeriesDimens.listItemHeight,
                          itemWidth: SeriesDimens.listItemWidth)
                      : HorizontalSeriesPosterListViewSection(
                          seriesList: provider.topRatedSeriesList,
                          sectionHeader: "Top Rated",
                        )
                ]),
              ],
            ),
          ),
        );
      },
    );
  }
}

class HorizontalSeriesPosterListViewSection extends StatelessWidget {
  final List<SeriesListModel> seriesList;
  final String? sectionHeader;

  const HorizontalSeriesPosterListViewSection(
      {Key? key, required this.seriesList, this.sectionHeader})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionHeader ?? "",
          style: TextStyle(
              color: Theme.of(context).primaryColorLight,
              fontSize: 24.0,
              fontWeight: FontWeight.w900,
              fontFamily: "Poppins"),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 260,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: seriesList.length,
              itemBuilder: (ctx, index) {
                SeriesListModel movie = seriesList[index];
                return Container(
                  margin: const EdgeInsets.fromLTRB(12.0, 4.0, 0.0, 4.0),
                  width: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 180,
                          width: 180,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              progressIndicatorBuilder:
                                  (context, url, progress) => Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).primaryColorLight,
                                  value: progress.progress,
                                ),
                              ),
                              imageUrl:
                                  "${ApiEndpoints.tmdbPosterPath}${movie.posterPath}",
                            ),
                          )),
                      const SizedBox(height: 4.0),
                      Text(
                        movie.originalName ?? "",
                        maxLines: 1,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Theme.of(context).primaryColorLight,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w300,
                            fontFamily: "Poppins"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Icon(Icons.star_rounded,
                                  color: Colors.amber),
                              const SizedBox(width: 2.0),
                              Text(
                                movie.voteAverage?.toStringAsFixed(1) ?? "",
                                maxLines: 1,
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color:
                                        Theme.of(context).primaryColorLight,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins"),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Text(
                              "${movie.firstAirDate?.year ?? ""}",
                              maxLines: 1,
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Theme.of(context).primaryColorLight,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins"),
                            ),
                          ),
                        ],
                      ),
                      // Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      //       IconButton(
                      //           iconSize: 16.0,
                      //           onPressed: () {},
                      //           icon: const Icon(CupertinoIcons.heart)),
                      //       IconButton(
                      //           iconSize: 16.0,
                      //           onPressed: () {},
                      //           icon: const Icon(CupertinoIcons.bookmark))
                      //     ])
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
