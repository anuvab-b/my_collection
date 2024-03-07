import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_collection/utils/routes/route_names.dart';
import 'package:my_collection/utils/routing_utils.dart';
import 'package:my_collection/view/widgets/common_loader.dart';
import 'package:my_collection/viewmodel/login/login_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            foregroundColor: Theme.of(context).primaryColor,
            backgroundColor: Theme.of(context).primaryColorDark,
            title: const Center(
                child: Text(
              "Login",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  fontFamily: "Poppins"),
            ))),
        body: Consumer<LoginProvider>(builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  TextFormField(
                    focusNode: provider.emailFocusNode,
                    onChanged: provider.onLoginTextFieldChange,
                    controller: provider.emailController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            )),
                        prefixIcon: Icon(Icons.mail_outline_rounded,
                            color: Theme.of(context).primaryColor),
                        labelText: "Email*",
                        hintText: "Enter your email address"),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                      focusNode: provider.passwordFocusNode,
                      onChanged: provider.onLoginTextFieldChange,
                      controller: provider.passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              )),
                          prefixIcon: Icon(Icons.lock_outline_rounded,
                              color: Theme.of(context).primaryColor),
                          labelText: "Password*",
                          hintText: "Enter your password")),
                  const SizedBox(height: 32.0),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColorLight),
                      )),
                  const SizedBox(height: 32.0),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: TextButton(
                      onPressed: provider.isLoginFormValidated()
                          ? () async {
                              provider.unFocusNodes();
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  barrierColor: Colors.transparent,
                                  builder: (ctx) {
                                    return const CommonLoader();
                                  });
                              User? user = await provider.onLoginButtonPress();
                              if (context.mounted) {
                                Navigator.of(context).pop();
                              }
                              if (user != null) {
                                if (context.mounted) {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      RouteNames.home,
                                      (Route<dynamic> route) => false);
                                  RoutingUtils.fetchInitialHomeData(context);
                                }
                              } else {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      provider?.loginErrMessage ?? "",
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    backgroundColor:
                                        Theme.of(context).primaryColorLight,
                                  ));
                                }
                              }
                            }
                          : null,
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(16),
                          ),
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Theme.of(context).primaryColorLight),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Flexible(
                      child: Text(
                        "Don't have an account ?",
                        maxLines: 1,
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Theme.of(context).primaryColorLight),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(context,
                            RouteNames.signup, (Route<dynamic> route) => false);
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 32.0),
                  Row(
                    children: [
                      Expanded(
                          child: Divider(
                              color: Theme.of(context).primaryColor,
                              thickness: 2)),
                      const SizedBox(width: 8.0),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          "OR",
                          maxLines: 1,
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Theme.of(context).primaryColorLight,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins"),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                          child: Divider(
                        color: Theme.of(context).primaryColor,
                        thickness: 2,
                      ))
                    ],
                  ),
                  const SizedBox(height: 32.0),
                  SizedBox(
                    height: 50,
                    child: TextButton(
                      onPressed: () async {
                        provider.unFocusNodes();
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            barrierColor: Colors.transparent,
                            builder: (ctx) {
                              return const CommonLoader();
                            });
                        User? user = await provider.signInWithGoogle();
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                        if (user != null) {
                          if (context.mounted) {
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                RouteNames.home,
                                    (Route<dynamic> route) => false);
                            RoutingUtils.fetchInitialHomeData(context);
                          }
                        } else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                              content: Text(
                                provider?.loginErrMessage ?? "",
                                style: TextStyle(
                                    color:
                                    Theme.of(context).primaryColor),
                              ),
                              backgroundColor:
                              Theme.of(context).primaryColorLight,
                            ));
                          }
                        }
                      },
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(16),
                          ),
                          backgroundColor: Theme.of(context).primaryColorLight,
                          foregroundColor: Theme.of(context).primaryColor),
                      child: Row(
                        children: [
                          const Icon(Icons.g_mobiledata),
                          const SizedBox(width: 32.0),
                          Text(
                            "Sign in with Google",
                            maxLines: 1,
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    height: 50,
                    child: TextButton(
                      onPressed: () async {},
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(16),
                          ),
                          backgroundColor: Theme.of(context).primaryColorLight,
                          foregroundColor: Theme.of(context).primaryColor),
                      child: Row(
                        children: [
                          const Icon(Icons.facebook),
                          const SizedBox(width: 32.0),
                          Text(
                            "Sign in with Facebook",
                            maxLines: 1,
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    height: 50,
                    child: TextButton(
                      onPressed: () async {},
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(16),
                          ),
                          backgroundColor: Theme.of(context).primaryColorLight,
                          foregroundColor: Theme.of(context).primaryColor),
                      child: Row(
                        children: [
                          const Icon(Icons.apple),
                          const SizedBox(width: 32.0),
                          Text(
                            "Sign in with Apple",
                            maxLines: 1,
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
