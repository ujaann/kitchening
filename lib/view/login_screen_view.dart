import 'package:flutter/material.dart';
import 'package:kitchening/common/gap.dart';
import 'package:kitchening/common/styles.dart';

class LoginScreenView extends StatelessWidget {
  const LoginScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w300),
            ),
            gap24Y,
            TextField(
              decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
            ),
            gap8Y,
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
            ),
            gap24Y,
            SizedBox(
              width: 260,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: orangey,foregroundColor: Colors.white),
                child: const Text("Login"),
              ),
            ),
            gap8Y,
            const Text("Already Have an Account?"),
            gap8Y,
            TextButton(onPressed: () {}, child: const Text("Register now"))
          ],
        ),
      )),
    );
  }
}
