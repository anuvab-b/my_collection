import 'package:flutter/cupertino.dart';

class LoginProvider extends ChangeNotifier{
  late TextEditingController emailController;
  late TextEditingController passwordController;

  LoginProvider(){
    initData();
  }

  initData(){
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  onLoginButtonPress(){

  }
}