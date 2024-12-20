import 'package:flutter/material.dart';
import 'package:kitchening/common/gap.dart';
import 'package:kitchening/common/my_snackbar.dart';
import 'package:kitchening/view/dashboard_screen_view.dart';
import 'package:kitchening/view/register_screen_view.dart';

class LoginScreenView extends StatefulWidget {
  const LoginScreenView({super.key});

  @override
  State<LoginScreenView> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<LoginScreenView> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  String? validateFields() {
    final pass = password.text;
    final user = username.text;

    if (user != "ujan" || pass != "ujan") {
      return "Invalid Credentials";
    }
    return null;
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome Back!",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w300),
            ),
            gap24Y,
            gap16Y,
            TextField(
              controller: username,
              decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
            ),
            gap16Y,
            TextField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
            ),
            gap24Y,
            SizedBox(
              width: 290,
              child: ElevatedButton(
                onPressed: () {
                  final error = validateFields();
                  if (error != null) {
                    showErrorSnackBar(context, message: error);
                  } else {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DashboardScreenView(),
                      ),
                      (route) => false,
                    );
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text("Login",
                      style: TextStyle(fontSize: 20, letterSpacing: 1)),
                ),
              ),
            ),
            gap16Y,
            const Text("Don't Have an Account?"),
            gap8Y,
            TextButton(
                onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreenView())),
                child: const Text(
                  "Register now",
                  style: TextStyle(decoration: TextDecoration.underline),
                )),
            // gap24Y,gap24Y,gap24Y,
          ],
        ),
      )),
    );
  }
}
