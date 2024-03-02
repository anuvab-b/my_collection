import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_collection/data/network/api_endpoints.dart';
import 'package:my_collection/models/movies/tmdb_movie_response_model.dart';
import 'package:my_collection/utils/dimens.dart';
import 'package:my_collection/utils/routes/route_names.dart';
import 'package:my_collection/view/movies/movie_search_delegate.dart';
import 'package:my_collection/view/widgets/search_widget_container.dart';
import 'package:my_collection/view/widgets/shimmer_layout.dart';
import 'package:my_collection/viewmodel/movie_provider.dart';
import 'package:my_collection/viewmodel/movie_watchlist_provider.dart';
import 'package:provider/provider.dart';

class MoviesHomeScreen extends StatelessWidget {
  const MoviesHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            child: Column(
              children: [
                Consumer<MovieWatchListProvider>(
                    builder: (context, watchListProvider, child) {
                  return watchListProvider.movieWatchLists.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16.0),
                            Text(
                              "Your Movie Watchlist collection",
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
                                      TmdbMovieResponseModel
                                          moviePlaylistModel = watchListProvider
                                              .movieWatchLists[index];
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
                                        .movieWatchLists.length)),
                          ],
                        )
                      : const SizedBox();
                }),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const SizedBox(height: 16.0),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextButton(
                            onPressed: () async {
                              Navigator.pushNamed(
                                  context, RouteNames.createMovieWatchListForm);
                            },
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                backgroundColor: Theme.of(context).primaryColor,
                                foregroundColor:
                                    Theme.of(context).primaryColorDark),
                            child: Text(
                              "Create a Watchlist",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                  fontSize: 18,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                      ]),
                  const SizedBox(height: 16.0),
                  SearchWidgetContainer(
                      hintText: "Search",
                      onTap: () {
                        showSearch(
                          context: context,
                          delegate: MovieSearchDelegate(buildContext: context),
                        );
                      }),
                  const SizedBox(height: 16.0),
                  provider.isNowPlayingLoading
                      ? ShimmerLayout(
                          layoutHeight: MovieDimens.listItemHeight,
                          itemHeight: MovieDimens.listItemHeight,
                          itemWidth: MovieDimens.listItemWidth)
                      : HorizontalMoviePosterListViewSection(
                          movieList: provider.nowPlayingMovieList,
                          sectionHeader: "Now Playing"),
                  const SizedBox(height: 16.0),
                  provider.isPopularLoading
                      ? ShimmerLayout(
                          layoutHeight: MovieDimens.listItemHeight,
                          itemHeight: MovieDimens.listItemHeight,
                          itemWidth: MovieDimens.listItemWidth)
                      : HorizontalMoviePosterListViewSection(
                          movieList: provider.popularMovieList,
                          sectionHeader: "Popular"),
                  const SizedBox(height: 16.0),
                  provider.isTopRatedLoading
                      ? ShimmerLayout(
                          layoutHeight: MovieDimens.listItemHeight,
                          itemHeight: MovieDimens.listItemHeight,
                          itemWidth: MovieDimens.listItemWidth)
                      : HorizontalMoviePosterListViewSection(
                          movieList: provider.topRatedMovieList,
                          sectionHeader: "Top Rated"),
                  const SizedBox(height: 16.0),
                  provider.isUpcomingLoading
                      ? ShimmerLayout(
                          layoutHeight: MovieDimens.listItemHeight,
                          itemHeight: MovieDimens.listItemHeight,
                          itemWidth: MovieDimens.listItemWidth)
                      : HorizontalMoviePosterListViewSection(
                          movieList: provider.upcomingMovieList,
                          sectionHeader: "Upcoming Releases",
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

class HorizontalMoviePosterListViewSection extends StatelessWidget {
  final List<MovieListModel> movieList;
  final String? sectionHeader;

  const HorizontalMoviePosterListViewSection(
      {Key? key, required this.movieList, this.sectionHeader})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
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
                itemCount: movieList.length,
                itemBuilder: (ctx, index) {
                  MovieListModel movie = movieList[index];
                  return InkWell(
                    onTap: () {
                      MovieProvider provider =
                          Provider.of<MovieProvider>(context, listen: false);
                      provider.setSelectedMovieListItem(movie);
                      provider.fetchMovieCredits();
                      provider.fetchMovieDetails();
                      Navigator.pushNamed(
                          context, RouteNames.movieDetailsScreen);
                    },
                    child: Container(
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
                                      value: progress.progress,
                                    ),
                                  ),
                                  imageUrl:
                                      "${ApiEndpoints.tmdbPosterPath}${movie.posterPath}",
                                ),
                              )),
                          const SizedBox(height: 4.0),
                          Text(
                            movie.title ?? "",
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
                                  "${movie.releaseDate?.year ?? ""}",
                                  maxLines: 1,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color:
                                          Theme.of(context).primaryColorLight,
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
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
