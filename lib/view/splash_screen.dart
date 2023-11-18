import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_collection/utils/routes/route_names.dart';
import 'package:my_collection/viewmodel/auth_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    checkIfUserLoggedIn();
  }

  checkIfUserLoggedIn()async{
    AuthProvider authProvider = context.read<AuthProvider>();
    bool res = await authProvider.checkIfUserLoggedIn();
    SchedulerBinding.instance.addPostFrameCallback((_)  {
      if(res == true) {
        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
              context,
              RouteNames.home,
                  (Route<dynamic> route) => false);
        }
      }
      else{
        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
              context,
              RouteNames.login,
                  (Route<dynamic> route) => false);
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
