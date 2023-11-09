import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_collection/data/network/api_endpoints.dart';
import 'package:my_collection/viewmodel/movie_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'widgets/placeholders/placeholder.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          child: Column(children: [
            provider.isNowPlayingLoading
                ? Shimmer.fromColors(
                    direction: ShimmerDirection.ltr,
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: const BannerPlaceholder())
                : Column(children: [
                    SizedBox(
                      height: MediaQuery.of(context)
                          .size
                          .width * 0.6,
                      child: PageView(
                          clipBehavior: Clip.none,
                          controller: provider.pageController,
                          onPageChanged: (value) {
                            provider.storeIndex(value);
                          },
                          children: provider.nowPlayingMovieList
                              .map((e) => Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0, vertical: 4.0),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4.0, vertical: 4.0),
                                    child: Card(
                                      shadowColor: Colors.grey,
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,

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
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                  ),
                );
              }),
            ),
            const SizedBox(height: 16.0),
            provider.isPopularLoading
                ? Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: const BannerPlaceholder())
                : Text("Loaded Popular"),
            const SizedBox(height: 16.0),
            provider.isTopRatedLoading
                ? Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: const BannerPlaceholder())
                : Text("Loaded Top Rated"),
            const SizedBox(height: 16.0),
            provider.isUpcomingLoading
                ? Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: const BannerPlaceholder())
                : Text("Loaded Upcoming")
          ]),
        );
      },
    );
  }
}
