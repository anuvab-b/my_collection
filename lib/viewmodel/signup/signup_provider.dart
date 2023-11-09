import 'package:flutter/cupertino.dart';

class SignupProvider extends ChangeNotifier{
  late TextEditingController emailController;
  late TextEditingController passwordController;

  SignupProvider(){
    initData();
  }

  initData(){
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  onGotoLoginButtonPress(){

  }
}