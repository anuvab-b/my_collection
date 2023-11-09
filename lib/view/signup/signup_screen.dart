import 'package:flutter/material.dart';
import 'package:my_collection/viewmodel/signup/signup_provider.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

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
                        decoration: const InputDecoration(
                            labelText: "Email*",
                            hintText: "Enter an email address"),
                      ),
                      TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                              labelText: "Password*",
                              hintText: "Enter a password")),
                    ],
                  ),
                  Column(children: [
                    const Text("Already have an account? Login here"),
                    TextButton(
                      onPressed: provider.onGotoLoginButtonPress,
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(16.0),
                          primary: Theme.of(context).primaryColor,
                          textStyle: const TextStyle(fontSize: 20)),
                      child: const Text("Login"),
                    )
                  ]),
                ]),
          );
        }));
  }
}
