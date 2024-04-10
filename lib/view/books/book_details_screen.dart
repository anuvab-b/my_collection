import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_collection/models/books/google_books_api_response_model.dart';
import 'package:my_collection/utils/data_utils.dart';
import 'package:my_collection/view/books/readinglist_list_view.dart';
import 'package:my_collection/view/widgets/common_loader.dart';
import 'package:my_collection/view/widgets/common_network_image.dart';
import 'package:my_collection/view/widgets/common_text.dart';
import 'package:my_collection/viewmodel/books_provider.dart';
import 'package:my_collection/viewmodel/reading_list_provider.dart';
import 'package:provider/provider.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BooksProvider>(builder: (context, provider, child) {
      BookListItem? book = provider?.selectedBookListItem;
      return Scaffold(
        appBar: AppBar(
          title: Text("Book Details",
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
                      tag: book?.id ?? "",
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
                                    "https://books.google.com/books/publisher/content/images/frontcover/${book?.id}?fife=w400-h600&source=gbs_api}"
                                    "${book?.volumeInfo.imageLinks?.thumbnail}",
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
                              title: book?.volumeInfo.title ?? "",
                              fontSize: 32.0,
                              fontWeight: FontWeight.w700),
                          CommonText(
                              title:
                                  "By ${DataUtils.getAuthorNamesStringFromList(book?.volumeInfo.authors)}",
                              color: Theme.of(context).primaryColorLight,
                              fontSize: 16.0),
                          const SizedBox(height: 16.0),
                          CommonText(
                              title: "${book?.volumeInfo.pageCount} pages",
                              color: Colors.white,
                              fontSize: 14.0),
                          const SizedBox(height: 16.0),
                          SizedBox(
                            height: 32,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    book?.volumeInfo.categories?.length ?? 0,
                                itemBuilder: (context, index) {
                                  var regex = RegExp(r'[\[\]]');

                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0, horizontal: 16.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    child: CommonText(
                                      title: "${book?.volumeInfo.categories}"
                                          .replaceAll(regex, ""),
                                    ),
                                  );
                                }),
                          ),
                          const SizedBox(height: 24.0),
                          CommonText(
                              title: "DESCRIPTION",
                              color: Theme.of(context).primaryColorLight,
                              fontWeight: FontWeight.w800,
                              fontSize: 18.0),
                          const SizedBox(height: 8.0),
                          CommonText(
                              title: "${book?.volumeInfo?.description}",
                              color: Theme.of(context).primaryColorLight,
                              fontWeight: FontWeight.w300,
                              fontSize: 20.0),
                        ],
                      ),
                    )
                  ],
                )),
              ),
              if (book != null)
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
                                        Expanded(child: ReadingListListView(
                                            onTap: (_) async {
                                              provider.setSelectedReadingListModel(provider.readingLists[_]);
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              barrierColor: Colors.transparent,
                                              builder: (ctx) {
                                                return const CommonLoader();
                                              });
                                          await provider
                                              .addNewBookToReadingList(book);
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
                        "Add to your Library",
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
