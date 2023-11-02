import 'package:flutter/material.dart';
import 'package:my_collection/res/assets.dart';
import 'package:my_collection/view/books_screen.dart';
import 'package:my_collection/view/movies_screen.dart';
import 'package:my_collection/view/music_screen.dart';
import 'package:my_collection/view/series_screen.dart';
import 'package:my_collection/viewmodel/home_screen_provider.dart';
import 'package:provider/provider.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeScreenProvider>(
      create: (context)=>HomeScreenProvider(),
      child: Scaffold(
        appBar: AppBar(),
        body: Consumer<HomeScreenProvider>(
            builder:
                (context,provider,child)
            {
              return IndexedStack(
                index: provider.selectedIndex,
                children: const [
                  BooksScreen(),
                  MoviesScreen(),
                  SeriesScreen(),
                  MusicScreen()
                ],
              );
            }),
        bottomNavigationBar: Consumer<HomeScreenProvider>(
          builder: (context,provider,child) {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: false,
              backgroundColor: Colors.white,
              showSelectedLabels: false,
              selectedLabelStyle: const TextStyle(fontSize: 8.0),
              currentIndex: provider.selectedIndex,
              onTap: provider.onBottomNavIndexChanged,
              items: [
                BottomNavigationBarItem(
                    icon: Column(
                      children: [
                        Image.asset(icBook, height: 24.0, width: 24.0),
                        const Text("Books"),
                      ],
                    ),
                    label: "Books"),
                BottomNavigationBarItem(
                    icon: Column(
                      children: [
                        Image.asset(icMovie, height: 24.0, width: 24.0),
                        const Text("Movies"),
                      ],
                    ),
                    label: "Movies"),
                BottomNavigationBarItem(
                    icon: Column(
                      children: [
                        Image.asset(icSeries, height: 24.0, width: 24.0),
                        const Text("Series"),
                      ],
                    ),
                    label: "Series"),
                BottomNavigationBarItem(
                    icon: Column(
                      children: [
                        Image.asset(icMusic, height: 24.0, width: 24.0),
                        const Text("Music"),
                      ],
                    ),
                    label: "Music")
              ],
            );
          }
        ),
      ),
    );
  }
}
