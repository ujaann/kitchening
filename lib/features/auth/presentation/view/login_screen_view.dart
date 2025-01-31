import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchening/app/common/gap.dart';
import 'package:kitchening/app/common/my_snackbar.dart';
import 'package:kitchening/features/auth/presentation/view/register_screen_view.dart';
import 'package:kitchening/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:kitchening/features/dashboard/presentation/view/dashboard_screen_view.dart';

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

    if (user.isEmpty || pass.isEmpty) {
      return "Please fill all the fields";
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
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
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
                    //added code for validation here
                    onPressed: () {
                      final error = validateFields();
                      if (error != null) {
                        showErrorSnackBar(context, message: error);
                        return;
                      }

                      context.read<LoginBloc>().add(LoginUserEvent(
                            username: username.text,
                            password: password.text,
                            context: context,
                            destination: const DashboardScreenView(),
                          ));
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
                    onPressed: () => context.read<LoginBloc>().add(
                        NavigateRegisterScreenEvent(
                            context: context,
                            destination: const RegisterScreenView())),
                    child: const Text(
                      "Register now",
                      style: TextStyle(decoration: TextDecoration.underline),
                    )),
                // gap24Y,gap24Y,gap24Y,
              ],
            ),
          ),
        ),
      )),
    );
  }
}
