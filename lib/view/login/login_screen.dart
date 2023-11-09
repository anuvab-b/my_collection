import 'package:flutter/material.dart';
import 'package:my_collection/viewmodel/login/login_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Login")),
        body: Consumer<LoginProvider>(
          builder: (context, provider, child) {
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
                              hintText: "Enter your email address"),
                        ),
                        TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                                labelText: "Password*",
                                hintText: "Enter password")),
                      ],
                    ),
                    TextButton(
                      onPressed: provider.onLoginButtonPress,
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(16.0),
                          primary: Theme.of(context).primaryColor,
                          textStyle: const TextStyle(fontSize: 20)),
                      child: const Text("Login"),
                    ),
                  ]),
            );
          }
        ));
  }
}
