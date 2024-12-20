import 'package:flutter/material.dart';
import 'package:kitchening/common/app_theme.dart';
import 'package:kitchening/view/splash_screen_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kitchening",
      color: const Color(0xffF1E0C5),
      theme: getApplicationTheme(),
      debugShowCheckedModeBanner: false,
      home: const SplashScreenView(),
    );
  }
}
