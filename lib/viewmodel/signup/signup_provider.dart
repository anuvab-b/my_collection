import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupProvider extends ChangeNotifier {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController nameController;
  late FirebaseAuth firebaseAuth;
  String? signUpErrMessage;

  SignupProvider() {
    initData();
  }

  initData() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    firebaseAuth = FirebaseAuth.instance;
  }
  Future<User?> onSignupButtonPress(BuildContext context) async {
    User? user;
    try {
      UserCredential newUser = await firebaseAuth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      user = newUser.user;
      await user!.updateDisplayName(nameController.text);
      await user.reload();
      user = firebaseAuth.currentUser;
      emailController.clear();
      passwordController.clear();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        signUpErrMessage = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        signUpErrMessage = "The account already exists for that email.";
      } else {
        signUpErrMessage = e.message.toString();
      }
    } catch (e) {
      signUpErrMessage = e.toString();
    }
    return user;
  }
}
