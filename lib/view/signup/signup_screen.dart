import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_collection/utils/routes/route_names.dart';
import 'package:my_collection/view/widgets/common_loader.dart';
import 'package:my_collection/viewmodel/signup/signup_provider.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Sign Up")),
        body: Consumer<SignupProvider>(builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      TextFormField(
                        controller: provider.emailController,
                        decoration: const InputDecoration(
                            labelText: "Email*",
                            hintText: "Enter an email address"),
                      ),
                      TextFormField(
                          controller: provider.passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              labelText: "Password*",
                              hintText: "Enter a password")),
                    ],
                  ),
                  Column(children: [
                    const Text("Already have an account? Login here"),
                    TextButton(
                      onPressed: () {
                        //     RouteNames.login, (Route<dynamic> route) => false);
                        Navigator.pushNamed(context,
                            RouteNames.login);
                      },
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(16.0),
                          foregroundColor: Theme.of(context).primaryColor,
                          textStyle: const TextStyle(fontSize: 20)),
                      child: const Text("Login"),
                    )
                  ]),
                ]),
          );
        }));
  }
}
