import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_collection/utils/secure_storage.dart';

class LoginProvider extends ChangeNotifier{
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FirebaseAuth firebaseAuth;

  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  String? loginErrMessage;

  LoginProvider(){
    initData();
  }

  initData(){
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    firebaseAuth = FirebaseAuth.instance;
  }

  Future<User?> onLoginButtonPress() async {
    User? user;
    try {
      UserCredential signInUser = await firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      emailController.clear();
      passwordController.clear();
      user = signInUser.user;
      SecureStorageManager().setSecureStorageData("user_id",user?.email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        loginErrMessage = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        loginErrMessage = "Wrong password provided for that user.";
      } else if(e.code == "INVALID_LOGIN_CREDENTIALS"){
        loginErrMessage = "Invalid login credentials";
      }
      else {
        loginErrMessage = e.message.toString();
      }
    } catch (e) {
      loginErrMessage = e.toString();
    }
    return user;
  }

  bool isLoginFormValidated() {
    return !(
        emailController.text.isEmpty ||
        passwordController.text.isEmpty);
  }

  onLoginTextFieldChange(String text){
    notifyListeners();
  }

  unFocusNodes(){
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
    notifyListeners();
  }
}