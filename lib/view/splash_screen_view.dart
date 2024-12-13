import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kitchening/view/login_screen_view.dart';
import 'package:kitchening/view/onboarding_screen_view.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 3), (_)=>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const OnboardingScreenView())));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1E0C5),
      body: SafeArea(
          child: Center(child: Image.asset("assets/images/logo.png"))          
          ),
    );
  }
}
