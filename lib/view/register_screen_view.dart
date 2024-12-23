import 'package:flutter/material.dart';
import 'package:kitchening/common/gap.dart';
import 'package:kitchening/common/my_snackbar.dart';
import 'package:kitchening/view/dashboard_screen_view.dart';
import 'package:kitchening/view/login_screen_view.dart';

class RegisterScreenView extends StatefulWidget {
  const RegisterScreenView({super.key});

  @override
  State<RegisterScreenView> createState() => _RegisterScreenViewState();
}

class _RegisterScreenViewState extends State<RegisterScreenView> {
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  String? validateFields() {
    final pass = password.text;
    final conPass = confirmPassword.text;

    if (username.text.length < 4 || pass.length < 4 || conPass.length < 4) {
      return "Username and password must be longer than 4 characters";
    }

    if (pass != conPass) {
      return "Error... Password does not match";
    }
    return null;
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    email.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Let's Get Started",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w300),
            ),
            gap24Y,
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
              controller: email,
              decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
              keyboardType: TextInputType.emailAddress,
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
            gap16Y,
            TextField(
              controller: confirmPassword,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "Confirm Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
            ),
            gap16Y,
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
                  child: Text("Register",
                      style: TextStyle(fontSize: 20, letterSpacing: 1)),
                ),
              ),
            ),
            gap16Y,
            const Text("Already Have an Account?"),
            gap8Y,
            TextButton(
                onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreenView())),
                child: const Text(
                  "Login now",
                  style: TextStyle(decoration: TextDecoration.underline),
                )),
          ],
        ),
      ),
    );
  }
}
