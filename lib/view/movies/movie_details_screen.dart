import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_collection/data/network/api_endpoints.dart';
import 'package:my_collection/models/movies/tmdb_movie_response_model.dart';
import 'package:my_collection/view/movies/movie_watchlist_list_view.dart';
import 'package:my_collection/view/widgets/common_loader.dart';
import 'package:my_collection/view/widgets/common_network_image.dart';
import 'package:my_collection/view/widgets/common_text.dart';
import 'package:my_collection/viewmodel/movie_provider.dart';
import 'package:my_collection/viewmodel/movie_watchlist_provider.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(builder: (context, provider, child) {
      MovieListModel? movie = provider?.selectedMovieListModel;
      return Scaffold(
        appBar: AppBar(
          title: Text("Movie Details",
              style: TextStyle(
                  fontFamily: "Poppins",
                  color: Theme.of(context).primaryColorLight)),
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left,
                color: Theme.of(context).primaryColorLight, size: 32.0),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32.0),
                    Hero(
                      tag: "${ApiEndpoints.tmdbPosterPath}${movie?.posterPath}",
                      child: Center(
                        child: SizedBox(
                            width: 300,
                            height: 400,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                errorWidget: (context, value, value2) {
                                  return const CommonPlaceholderNetworkImage();
                                },
                                fit: BoxFit.fill,
                                progressIndicatorBuilder:
                                    (context, url, progress) => Center(
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context).primaryColorLight,
                                    value: progress.progress,
                                  ),
                                ),
                                imageUrl:
                                    "${ApiEndpoints.tmdbPosterPath}${movie?.posterPath}",
                              ),
                            )),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16.0),
                          CommonText(
                              title: movie?.title ?? "",
                              fontSize: 32.0,
                              fontWeight: FontWeight.w700),
                          const SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "${movie?.releaseDate?.year ?? ""}",
                                    maxLines: 1,
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Poppins"),
                                  ),
                                  if (!provider.isMovieDetailsLoading)
                                    Text(
                                      " / ${provider.movieDetailsResponseModel?.runtime ?? ""} min.",
                                      maxLines: 1,
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          fontSize: 16.0,
                                          fontFamily: "Poppins"),
                                    ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(Icons.star_rounded,
                                      color: Colors.amber),
                                  const SizedBox(width: 2.0),
                                  Text(
                                    movie?.voteAverage?.toStringAsFixed(1) ??
                                        "",
                                    maxLines: 1,
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Poppins"),
                                  ),
                                  const SizedBox(width: 2.0),
                                  Text(
                                    "(${movie?.voteCount} Reviews)",
                                    maxLines: 1,
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        fontSize: 16.0,
                                        fontFamily: "Poppins"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          if (!provider.isMovieDetailsLoading)
                            SizedBox(
                              height: 32,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: provider.movieDetailsResponseModel
                                          ?.genres.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin:
                                          const EdgeInsets.only(right: 12.0),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 16.0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      child: CommonText(
                                        title:
                                            "${provider.movieDetailsResponseModel?.genres[index].name}",
                                      ),
                                    );
                                  }),
                            ),
                          const SizedBox(height: 32.0),
                          if (!provider.isMovieCreditsLoading)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(
                                    title: "CAST",
                                    color: Theme.of(context).primaryColorLight,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18.0),
                                const SizedBox(height: 12.0),
                                SizedBox(
                                  // color: Colors.yellow,
                                  height: 132,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: provider
                                              .movieCreditsResponseModel
                                              ?.cast
                                              .length ??
                                          0,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: const EdgeInsets.only(
                                              right: 12.0),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0, horizontal: 16.0),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                  height: 96,
                                                  width: 96,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    child: CachedNetworkImage(
                                                      errorWidget: (context,
                                                          value, value2) {
                                                        return const CommonPlaceholderNetworkImage();
                                                      },
                                                      fit: BoxFit.fill,
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  progress) =>
                                                              Center(
                                                        child: CircularProgressIndicator(
                                                            value: progress
                                                                .progress,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColorLight),
                                                      ),
                                                      imageUrl:
                                                          "${ApiEndpoints.tmdbPosterPath}${provider.movieCreditsResponseModel?.cast[index].profilePath}",
                                                    ),
                                                  )),
                                              CommonText(
                                                title:
                                                    "${provider.movieCreditsResponseModel?.cast[index].name}",
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          const SizedBox(height: 16.0),
                          CommonText(
                              title: "DESCRIPTION",
                              color: Theme.of(context).primaryColorLight,
                              fontWeight: FontWeight.w800,
                              fontSize: 18.0),
                          const SizedBox(height: 8.0),
                          CommonText(
                              title: "${movie?.overview}",
                              color: Theme.of(context).primaryColorLight,
                              fontWeight: FontWeight.w300,
                              fontSize: 20.0),
                        ],
                      ),
                    )
                  ],
                )),
              ),
              if (movie != null)
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16.0),
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                            // Set this when inner content overflows, making RoundedRectangleBorder not working as expected
                            clipBehavior: Clip.antiAlias,
                            // Set shape to make top corners rounded
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                            ),
                            enableDrag: true,
                            // isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return Consumer<MovieWatchListProvider>(
                                  builder: (context, provider, child) {
                                return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 16.0),
                                    color: Theme.of(context).primaryColor,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Add to a Movie Watchlist",
                                            style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 24)),
                                        Expanded(child: MovieWatchListListView(
                                            onTap: (_) async {
                                          provider
                                              .setSelectedMovieWatchListItem(
                                                  provider.movieWatchLists[_]);
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              barrierColor: Colors.transparent,
                                              builder: (ctx) {
                                                return const CommonLoader();
                                              });
                                          await provider.addNewMovieToWatchList(
                                              movie, _);
                                          if (context.mounted) {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                          }
                                        })),
                                      ],
                                    ));
                              });
                            });
                      },
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                                color: Theme.of(context).primaryColorLight),
                          ),
                          backgroundColor: Colors.white,
                          foregroundColor: Theme.of(context).primaryColorDark),
                      child: const Text(
                        "Add to your Movie Collection",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600),
                      ),
                    )),
            ],
          ),
        ),
      );
    });
  }
}
