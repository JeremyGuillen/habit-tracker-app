import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:habit_tracker/api/auth/auth_api.dart';
import 'package:habit_tracker/api/utils/flutter_store_controller.dart';
import 'package:habit_tracker/models/sign_in_response.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _loading = false;

  Future<void> onSignInPress(BuildContext context) async {
    setState(() {
      _loading = true;
    });
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      return;
    }
    var authApi = AuthApi();
    Map<String, dynamic> credentials = {
      'email': emailController.text,
      'password': passwordController.text,
    };

    SignInResponse? response = await authApi.signIn(credentials);
    setState(() {
      _loading = false;
    });
    if (response != null) {
      var secureStore = FlutterStore();
      print(response.idToken);
      await secureStore.storeValue("jwt_token", response.idToken);
      Navigator.pushNamed(context, "/home");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Habit tracker app'),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  alignment: Alignment.center,
                  child: Text('Sign In',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Email'),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Password'),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                            onPressed: (() => onSignInPress(context)),
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(16.0)),
                            icon: _loading
                                ? Container(
                                    width: 24,
                                    height: 24,
                                    padding: const EdgeInsets.all(2.0),
                                    child: const CircularProgressIndicator(
                                      color: Colors.blue,
                                      strokeWidth: 3,
                                    ),
                                  )
                                : const Icon(Icons.lock_open),
                            label: const Text("Sign in")),
                      ]),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
