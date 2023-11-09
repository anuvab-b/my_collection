import 'package:flutter/material.dart';
import 'package:my_collection/data/network/network.dart';
import 'package:my_collection/utils/routes/route_names.dart';
import 'package:my_collection/utils/routes/routes.dart';
import 'package:my_collection/viewmodel/home_screen_provider.dart';
import 'package:my_collection/viewmodel/login/login_provider.dart';
import 'package:my_collection/viewmodel/movie_provider.dart';
import 'package:my_collection/viewmodel/music_provider.dart';
import 'package:my_collection/viewmodel/signup/signup_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> LoginProvider()),
        ChangeNotifierProvider(create: (_)=> SignupProvider()),
        ChangeNotifierProvider(create: (_)=> DarkThemeProvider()),
        ChangeNotifierProvider(create: (_)=> ApiHelper()),
        ChangeNotifierProvider(create: (_)=> MusicProvider()),
        ChangeNotifierProvider(create: (_)=> MovieProvider()),
        ChangeNotifierProvider(create: (_)=> HomeScreenProvider())
      ],
      child: MaterialApp(
        title: "My Collection",
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        initialRoute: RouteNames.home,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
