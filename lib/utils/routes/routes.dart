import 'package:flutter/material.dart';
import 'package:my_collection/utils/routes/route_names.dart';
import 'package:my_collection/view/error_screen.dart';
import 'package:my_collection/view/home_screen.dart';
import 'package:my_collection/view/login/login_screen.dart';
import 'package:my_collection/view/music/music_search_screen.dart';
import 'package:my_collection/view/signup/signup_screen.dart';
import 'package:my_collection/view/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.login:
        return SlideRightRoute(widget: const LoginScreen());
      case RouteNames.signup:
        return SlideRightRoute(widget: const SignupScreen());
      case RouteNames.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RouteNames.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case RouteNames.musicSearch:
        return SlideRightRoute(widget: const MusicSearchScreen());

      default:
        return MaterialPageRoute(builder: (context) => const ErrorScreen());
    }
  }
}

class MyPageRouteBuilder extends PageRouteBuilder {
  final RouteSettings routeSettings;

  MyPageRouteBuilder(
      {Key? key, required this.routeSettings, required super.pageBuilder});

  PageRouteBuilder build(BuildContext context) {
    return PageRouteBuilder(
        settings: routeSettings,
        // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
        pageBuilder: super.pageBuilder,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget widget;

  SlideRightRoute({required this.widget})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return widget;
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        });
}
