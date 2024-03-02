import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_collection/models/books/google_books_api_response_model.dart';
import 'package:my_collection/utils/routes/route_names.dart';
import 'package:my_collection/view/books/readinglist_details_screen.dart';
import 'package:my_collection/view/books/readinglist_list_view.dart';
import 'package:my_collection/view/widgets/common_loader.dart';
import 'package:my_collection/viewmodel/books_provider.dart';
import 'package:my_collection/viewmodel/reading_list_provider.dart';
import 'package:provider/provider.dart';

class BookSearchDelegate extends SearchDelegate {
  BuildContext buildContext;

  BookSearchDelegate({required this.buildContext});

  @override
  String get searchFieldLabel => "What do you want to read?";

  @override
  TextStyle get searchFieldStyle => TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w200,
      fontFamily: "Poppins",
      color: Theme.of(buildContext).primaryColorLight);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          final bookProvider =
              Provider.of<BooksProvider>(context, listen: false);
          bookProvider.onSearchQueryChanged(query);
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer<BooksProvider>(builder: (context, provider, child) {
      return Container(
        margin: const EdgeInsets.all(16),
        child: FutureBuilder(
            future: provider.getBookBySearch(query),
            builder: (BuildContext context,
                AsyncSnapshot<Either<String, List<BookListItem>>?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                var result = snapshot.data;
                String message = "";
                List<BookListItem> books = [];
                result!.fold((l) {
                  message = l;
                }, (r) {
                  books = r;
                });
                if (message.isNotEmpty) {
                  return Center(
                      child: Text(message ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: Theme.of(context).primaryColorLight)));
                } else {
                  return ReadingListDetailsScreen(
                    books: books,
                    onItemMenuIconTap: () {
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
                            return Consumer<ReadingListProvider>(
                                builder: (context, provider, child) {
                              return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 16.0),
                                  color: Theme.of(context).primaryColor,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Add to a Reading list",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 24)),
                                      Expanded(child:
                                          ReadingListListView(onTap: (_) async {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            barrierColor: Colors.transparent,
                                            builder: (ctx) {
                                              return const CommonLoader();
                                            });
                                        await provider
                                            .addNewBookToReadingList(books[_]);
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
                    onItemTap: (_) {
                      provider.setSelectedBookListItem(books[_]);
                      Navigator.pushNamed(
                          context, RouteNames.bookDetailsScreen);
                    },
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
          Text("Read what you love",
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Theme.of(context).primaryColorLight,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Poppins")),
          const SizedBox(height: 8.0),
          Text("Search for Books, Novels and more",
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
