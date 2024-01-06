import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_collection/data/network/api_endpoints.dart';
import 'package:my_collection/models/movies/tmdb_movie_response_model.dart';
import 'package:my_collection/viewmodel/movie_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:my_collection/view/widgets/placeholders/placeholder.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            child: Column(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const SizedBox(height: 16.0),
                  provider.isNowPlayingLoading
                      ? Shimmer.fromColors(
                          direction: ShimmerDirection.ltr,
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: const BannerPlaceholder())
                      : Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Currently Watching",
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: "Poppins"),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: PageView(
                                      clipBehavior: Clip.none,
                                      controller: provider.pageController,
                                      onPageChanged: (value) {
                                        provider.storeIndex(value);
                                      },
                                      children: provider.nowPlayingMovieList
                                          .map((e) => Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4.0,
                                                        vertical: 4.0),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4.0,
                                                        vertical: 4.0),
                                                child: Card(
                                                  shadowColor: Colors.grey,
                                                  child: Stack(
                                                    children: [
                                                      ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          child: SizedBox(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            child:
                                                                CachedNetworkImage(
                                                              fit: BoxFit.fill,
                                                              progressIndicatorBuilder:
                                                                  (context, url,
                                                                          progress) =>
                                                                      Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  value: progress
                                                                      .progress,
                                                                      color: Theme.of(context).primaryColorLight,
                                                                ),
                                                              ),
                                                              imageUrl:
                                                                  "${ApiEndpoints.tmdbPosterPath}${e.posterPath}",
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ))
                                          .toList()),
                                ),
                              ]),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(
                        provider.nowPlayingMovieList.length > 3
                            ? 3
                            : provider.nowPlayingMovieList.length, (int index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: index == provider.selectedPageIndex ? 24.0 : 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          // shape: BoxShape.circle,
                          color: index == provider.selectedPageIndex
                              ? Theme.of(context).highlightColor
                              : Theme.of(context).primaryColorLight,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    height: 64,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Search",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                    color:
                                        Theme.of(context).primaryColorLight)),
                            Icon(Icons.search,
                                color: Theme.of(context).primaryColorLight)
                          ],
                        )),
                  ),
                  const SizedBox(height: 16.0),
                  provider.isNowPlayingLoading
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: const BannerPlaceholder())
                      : HorizontalMoviePosterListViewSection(
                          movieList: provider.nowPlayingMovieList,
                          sectionHeader: "Now Playing"),
                  const SizedBox(height: 16.0),
                  provider.isPopularLoading
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: const BannerPlaceholder())
                      : HorizontalMoviePosterListViewSection(
                          movieList: provider.popularMovieList,
                          sectionHeader: "Popular"),
                  const SizedBox(height: 16.0),
                  provider.isTopRatedLoading
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: const BannerPlaceholder())
                      : HorizontalMoviePosterListViewSection(
                          movieList: provider.topRatedMovieList,
                          sectionHeader: "Top Rated"),
                  const SizedBox(height: 16.0),
                  provider.isUpcomingLoading
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: const BannerPlaceholder())
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
      ),
    );
  }
}
