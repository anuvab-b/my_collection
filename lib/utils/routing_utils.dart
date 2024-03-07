import 'package:flutter/material.dart';
import 'package:my_collection/viewmodel/books_provider.dart';
import 'package:my_collection/viewmodel/reading_list_provider.dart';
import 'package:provider/provider.dart';

class RoutingUtils{
  static void fetchInitialHomeData(BuildContext context){
    BooksProvider booksProvider = Provider.of<BooksProvider>(
        context, listen: false);
    ReadingListProvider readingListProvider = Provider.of<ReadingListProvider>(context, listen: false);
    booksProvider.fetchBookHomeScreenData();
    readingListProvider.fetchReadingLists();
  }
}