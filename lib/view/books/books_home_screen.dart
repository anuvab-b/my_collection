import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_collection/models/books/google_books_api_response_model.dart';
import 'package:my_collection/utils/data_utils.dart';
import 'package:my_collection/utils/routes/route_names.dart';
import 'package:my_collection/view/books/book_search_delegate.dart';
import 'package:my_collection/view/widgets/common_network_image.dart';
import 'package:my_collection/view/widgets/placeholders/placeholder.dart';
import 'package:my_collection/view/widgets/search_widget_container.dart';
import 'package:my_collection/viewmodel/books_provider.dart';
import 'package:my_collection/viewmodel/reading_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class BooksHomeScreen extends StatelessWidget {
  const BooksHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BooksProvider>(builder: (context, provider, child) {
      return SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<ReadingListProvider>(
                      builder: (context, readListProvider, child) {
                    return readListProvider.readingLists.isNotEmpty
                        ? SizedBox(
                            height: 180,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (ctx, index) {
                                  GoogleBooksApiResponseModel bookModel =
                                      readListProvider.readingLists[index];
                                  return Card(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 120,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.book_rounded),
                                          Text(bookModel.kind,
                                              style: const TextStyle(
                                                  fontFamily: "Poppins")),
                                          Text(
                                              "${bookModel.items.length} items",
                                              style: const TextStyle(
                                                  fontFamily: "Poppins")),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount:
                                    readListProvider.readingLists.length))
                        : const SizedBox();
                  }),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      onPressed: () async {
                        Navigator.pushNamed(
                            context, RouteNames.createReadingListForm);
                      },
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Theme.of(context).primaryColorDark),
                      child: Text(
                        "Create a Reading list",
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                            fontSize: 18,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SearchWidgetContainer(
                      hintText: "Search",
                      onTap: () {
                        showSearch(
                          context: context,
                          delegate: BookSearchDelegate(buildContext: context),
                        );
                      }),
                  const SizedBox(height: 16.0),
                  HorizontalBookPosterListViewSection(
                      bookList: provider.booksOnSelfImprovement,
                      sectionHeader: DataUtils.getBookCategoryStringFromEnum(
                          BookCategories.selfImprovement),
                      isSectionLoading: provider.isSelfImpLoading),
                  HorizontalBookPosterListViewSection(
                      bookList: provider.booksOnFinance,
                      sectionHeader: DataUtils.getBookCategoryStringFromEnum(
                          BookCategories.finance),
                      isSectionLoading: provider.isFinanceLoading),
                  HorizontalBookPosterListViewSection(
                      bookList: provider.booksOnPsychology,
                      sectionHeader: DataUtils.getBookCategoryStringFromEnum(
                          BookCategories.psychology),
                      isSectionLoading: provider.isPsychologyLoading),
                  HorizontalBookPosterListViewSection(
                      bookList: provider.booksOnCrime,
                      sectionHeader: DataUtils.getBookCategoryStringFromEnum(
                          BookCategories.crime),
                      isSectionLoading: provider.isCrimeLoading)
                ],
              )));
    });
  }
}

class HorizontalBookPosterListViewSection extends StatelessWidget {
  final List<BookListItem> bookList;
  final String? sectionHeader;
  final bool isSectionLoading;

  const HorizontalBookPosterListViewSection(
      {Key? key,
      required this.bookList,
      this.sectionHeader,
      this.isSectionLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isSectionLoading)
          Text(
            sectionHeader ?? "",
            style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontSize: 24.0,
                fontWeight: FontWeight.w900,
                fontFamily: "Poppins"),
          ),
        if (!isSectionLoading) const SizedBox(height: 8.0),
        SizedBox(
            height: 260,
            child: (!isSectionLoading)
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: bookList.length,
                    itemBuilder: (ctx, index) {
                      BookListItem book = bookList[index];
                      return InkWell(
                        onTap: (){
                          BooksProvider provider = Provider.of<BooksProvider>(context, listen: false);
                          provider.setSelectedBookListItem(book);
                          Navigator.pushNamed(
                              context, RouteNames.bookDetailsScreen);
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(12.0, 4.0, 0.0, 4.0),
                          width: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: 150,
                                  height: 200,
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
                                          color:
                                              Theme.of(context).primaryColorLight,
                                          value: progress.progress,
                                        ),
                                      ),
                                      imageUrl:
                                          "${book?.volumeInfo?.imageLinks?.thumbnail}",
                                    ),
                                  )),
                              const SizedBox(height: 4.0),
                              Text(
                                book?.volumeInfo?.title ?? "",
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
                                  Flexible(
                                    child: Text(
                                      "By ${book?.volumeInfo.authors?.join(',') ?? ""}",
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
                                  if (book?.volumeInfo.publishedDate?.year !=
                                      null)
                                    Container(
                                      padding: const EdgeInsets.all(2.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4.0),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      child: Text(
                                        "${book?.volumeInfo.publishedDate?.year ?? ""}",
                                        maxLines: 1,
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: Theme.of(context)
                                                .primaryColorLight,
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
                    })
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (ctx, index) {
                      return SizedBox(
                        child: Shimmer.fromColors(
                            direction: ShimmerDirection.ltr,
                            baseColor: Colors.grey.shade900,
                            highlightColor: Colors.grey.shade800,
                            period: const Duration(milliseconds: 900),
                            enabled: true,
                            child: const BannerPlaceholder(
                              borderRadius: 8.0,
                              width: 150,
                              height: 200,
                            )),
                      );
                    })),
      ],
    );
  }
}
