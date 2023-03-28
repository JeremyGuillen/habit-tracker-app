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

  Future<void> onSignInPress(BuildContext context) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      return;
    }
    var authApi = AuthApi();
    Map<String, dynamic> credentials = {
      'email': emailController.text,
      'password': passwordController.text,
    };

    SignInResponse? response = await authApi.signIn(credentials);
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
                        ElevatedButton(
                            onPressed: (() => onSignInPress(context)),
                            child: Text('Sign in'))
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
