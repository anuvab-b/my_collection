import 'package:flutter/material.dart';
import 'package:my_collection/utils/routes/route_names.dart';
import 'package:my_collection/view/error_screen.dart';
import 'package:my_collection/view/home_screen.dart';
import 'package:my_collection/view/login_screen.dart';
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
      default:
        return MaterialPageRoute(builder: (context)=> const ErrorScreen());
    }
  }
}