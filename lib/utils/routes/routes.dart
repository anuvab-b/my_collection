import 'package:flutter/material.dart';
import 'package:my_collection/utils/routes/route_names.dart';
import 'package:my_collection/view/error_screen.dart';
import 'package:my_collection/view/home_screen.dart';
import 'package:my_collection/view/login_screen.dart';
import 'package:my_collection/view/music/music_search_screen.dart';
import 'package:my_collection/view/signup_screen.dart';
import 'package:my_collection/view/splash_screen.dart';

class Routes{

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RouteNames.login:
        return MaterialPageRoute(builder: (context)=> const LoginScreen());
      case RouteNames.signup:
        return MaterialPageRoute(builder: (context)=>const SignupScreen());
      case RouteNames.splash:
        return MaterialPageRoute(builder: (context)=> const SplashScreen());
      case RouteNames.home:
        return MaterialPageRoute(builder: (context)=> const HomeScreen());
      case RouteNames.musicSearch:
        return PageRouteBuilder(
            settings: settings, // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
            pageBuilder: (_, __, ___) => const MusicSearchScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child){
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.ease;

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            }
        );
      default:
        return MaterialPageRoute(builder: (context)=> const ErrorScreen());
    }
  }
}