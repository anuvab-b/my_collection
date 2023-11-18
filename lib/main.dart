import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_collection/data/network/network.dart';
import 'package:my_collection/utils/routes/route_names.dart';
import 'package:my_collection/utils/routes/routes.dart';
import 'package:my_collection/utils/theme_styles.dart';
import 'package:my_collection/viewmodel/auth_provider.dart';
import 'package:my_collection/viewmodel/books_provider.dart';
import 'package:my_collection/viewmodel/dark_theme_provider.dart';
import 'package:my_collection/viewmodel/home_screen_provider.dart';
import 'package:my_collection/viewmodel/login/login_provider.dart';
import 'package:my_collection/viewmodel/movie_provider.dart';
import 'package:my_collection/viewmodel/music_provider.dart';
import 'package:my_collection/viewmodel/series_provider.dart';
import 'package:my_collection/viewmodel/signup/signup_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => LoginProvider()),
          ChangeNotifierProvider(create: (_) => SignupProvider()),
          ChangeNotifierProvider(create: (_) => ApiHelper()),
          ChangeNotifierProvider(create: (_) => themeChangeProvider),
          ChangeNotifierProvider(create: (_) => MusicProvider()),
          ChangeNotifierProvider(create: (_) => MovieProvider()),
          ChangeNotifierProvider(create: (_) => BooksProvider()),
          ChangeNotifierProvider(create: (_) => SeriesProvider()),
          ChangeNotifierProvider(create: (_) => HomeScreenProvider())
        ],
        child: Consumer<DarkThemeProvider>(builder: (ctx, provider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "My Collection",
              theme: Styles.themeData(provider.darkTheme, context),
              // darkTheme: ThemeData.dark(),
              initialRoute: RouteNames.splash,
              onGenerateRoute: Routes.generateRoute,// If you set routes, it ignores onGenerateRoute
              // routes: {
              //   RouteNames.home: (context) => const HomeScreen(),
              //   RouteNames.musicSearch: (context) => const MusicSearchScreen()
              // },
            );
          },
        ));
  }
}
