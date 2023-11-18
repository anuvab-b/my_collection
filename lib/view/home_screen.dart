import 'package:flutter/material.dart';
import 'package:my_collection/res/assets.dart';
import 'package:my_collection/utils/routes/route_names.dart';
import 'package:my_collection/view/books/books_screen.dart';
import 'package:my_collection/view/movies/movies_screen.dart';
import 'package:my_collection/view/music/music_screen.dart';
import 'package:my_collection/view/series/series_screen.dart';
import 'package:my_collection/viewmodel/auth_provider.dart';
import 'package:my_collection/viewmodel/dark_theme_provider.dart';
import 'package:my_collection/viewmodel/home_screen_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeScreenProvider>(
      create: (ctx) => HomeScreenProvider(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
                // color: kSelectedListItem,
                onSelected: (value) {
                  // controller.onMenuItemSelected(value);
                  if (value == 0) {
                    var themeChange =
                        Provider.of<DarkThemeProvider>(context, listen: false);
                    themeChange.darkTheme = !themeChange.darkTheme;
                  } else if (value == 1) {
                    AuthProvider authProvider = context.read<AuthProvider>();
                    authProvider.logOutUser();
                    Navigator.pushNamedAndRemoveUntil(context, RouteNames.login,
                        (Route<dynamic> route) => false);
                  }
                },
                offset: Offset(0.0, AppBar().preferredSize.height),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                itemBuilder: (ctx) {
                  return [
                    PopupMenuItem(
                        value: 0,
                        child: SizedBox(
                            width: 312,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.change_circle_rounded,
                                    color: Theme.of(context).indicatorColor),
                                const SizedBox(width: 12.0),
                                const Expanded(
                                  child: Text("Change Theme",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ))),
                    PopupMenuItem(
                        value: 1,
                        child: SizedBox(
                            width: 312,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.logout_outlined,
                                    color: Theme.of(context).indicatorColor),
                                const SizedBox(width: 12.0),
                                const Expanded(
                                  child: Text("Sign Out",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            )))
                  ];
                }),
          ],
        ),
        body: Consumer<HomeScreenProvider>(builder: (context, provider, child) {
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
        bottomNavigationBar:
            Consumer<HomeScreenProvider>(builder: (context, provider, child) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: false,
                backgroundColor:
                    Theme.of(context).primaryColor.withOpacity(0.4),
                showSelectedLabels: false,
                selectedLabelStyle: const TextStyle(fontSize: 8.0),
                currentIndex: provider.selectedIndex,
                onTap: (_) => provider.onBottomNavIndexChanged(_, context),
                items: [
                  BottomNavigationBarItem(
                      icon: Column(
                        children: [
                          Image.asset(icBook, height: 24.0, width: 24.0),
                          Text("Books",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      label: "Books"),
                  BottomNavigationBarItem(
                      icon: Column(
                        children: [
                          Image.asset(icMovie, height: 24.0, width: 24.0),
                          Text("Movies",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      label: "Movies"),
                  BottomNavigationBarItem(
                      icon: Column(
                        children: [
                          Image.asset(icSeries, height: 24.0, width: 24.0),
                          Text("Series",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      label: "Series"),
                  BottomNavigationBarItem(
                      icon: Column(
                        children: [
                          Image.asset(icMusic, height: 24.0, width: 24.0),
                          Text("Music",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      label: "Music")
                ],
              ));
        }),
      ),
    );
  }
}
