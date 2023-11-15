import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_collection/models/books/google_books_api_response_model.dart';
import 'package:my_collection/utils/data_utils.dart';
import 'package:my_collection/view/widgets/placeholders/placeholder.dart';
import 'package:my_collection/viewmodel/books_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BooksProvider>(builder: (context, provider, child) {
      return SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
              child: Column(
                children: [
                  HorizontalBookPosterListViewSection(
                      bookList: provider.booksOnSelfImprovement.items,
                      sectionHeader: DataUtils.getBookCategoryStringFromEnum(BookCategories.selfImprovement),
                      isSectionLoading: provider.isSelfImpLoading),
                  HorizontalBookPosterListViewSection(
                      bookList: provider.booksOnFinance.items,
                      sectionHeader: DataUtils.getBookCategoryStringFromEnum(BookCategories.finance),
                      isSectionLoading: provider.isFinanceLoading), HorizontalBookPosterListViewSection(
                      bookList: provider.booksOnPsychology.items,
                      sectionHeader: DataUtils.getBookCategoryStringFromEnum(BookCategories.psychology),
                      isSectionLoading: provider.isPsychologyLoading),
                  HorizontalBookPosterListViewSection(
                      bookList: provider.booksOnCrime.items,
                      sectionHeader: DataUtils.getBookCategoryStringFromEnum(BookCategories.crime),
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
                      return Container(
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
                                      return Image.network(
                                          "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/310px-Placeholder_view_vector.svg.png",
                                          fit: BoxFit.fill);
                                    },
                                    fit: BoxFit.fill,
                                    progressIndicatorBuilder:
                                        (context, url, progress) => Center(
                                      child: CircularProgressIndicator(
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
                                if(book?.volumeInfo.publishedDate?.year!=null)
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
