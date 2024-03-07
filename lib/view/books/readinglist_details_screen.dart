import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_collection/models/books/google_books_api_response_model.dart';
import 'package:my_collection/view/books/readinglist_list_view.dart';
import 'package:my_collection/view/widgets/common_loader.dart';
import 'package:my_collection/view/widgets/common_network_image.dart';
import 'package:my_collection/viewmodel/reading_list_provider.dart';
import 'package:provider/provider.dart';

class ReadingListDetailsScreen extends StatelessWidget {
  final List<BookListItem> books;
  final Function(int) onItemTap;
  final VoidCallback onItemMenuIconTap;

  const ReadingListDetailsScreen(
      {Key? key,
      required this.books,
      required this.onItemTap,
      required this.onItemMenuIconTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: books.length,
              itemBuilder: (ctx, index) {
                BookListItem bookListModel = books[index];
                return InkWell(
                  onTap: () {
                    onItemTap(index);
                  },
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Row(
                                children: [
                                  SizedBox(
                                      width: 60,
                                      height: 80,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                          errorWidget:
                                              (context, value, value2) {
                                            return const CommonPlaceholderNetworkImage();
                                          },
                                          fit: BoxFit.fill,
                                          progressIndicatorBuilder:
                                              (context, url, progress) =>
                                                  Center(
                                            child: CircularProgressIndicator(
                                              color: Theme.of(context)
                                                  .primaryColorLight,
                                              value: progress.progress,
                                            ),
                                          ),
                                          imageUrl:
                                              "${bookListModel?.volumeInfo?.imageLinks?.thumbnail}",
                                        ),
                                      )),
                                  const SizedBox(width: 8.0),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            bookListModel?.volumeInfo?.title ??
                                                "",
                                            maxLines: 3,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context)
                                                    .highlightColor)),
                                        const SizedBox(height: 4.0),
                                      ],
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
                                            builder:
                                                (context, provider, child) {
                                          return Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 16.0),
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                      "Add to a Reading list",
                                                      style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 24)),
                                                  Expanded(child:
                                                      ReadingListListView(
                                                          onTap: (_) async {
                                                            provider.setSelectedReadingListModel(provider.readingLists[_]);
                                                            showDialog(
                                                        context: context,
                                                        barrierDismissible:
                                                            false,
                                                        barrierColor:
                                                            Colors.transparent,
                                                        builder: (ctx) {
                                                          return const CommonLoader();
                                                        });
                                                    await provider
                                                        .addNewBookToReadingList(
                                                            bookListModel);
                                                    if (context.mounted) {
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context)
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
              })
        ],
      ),
    );
  }
}
