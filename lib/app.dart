import 'package:flutter/material.dart';
import 'package:kitchening/common/styles.dart';
import 'package:kitchening/view/splash_screen_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kitchening",
      color: const Color(0xffF1E0C5),
      theme: ThemeData(
        scaffoldBackgroundColor: lightBrown,
        inputDecorationTheme: const InputDecorationTheme(filled: true,fillColor: Color(0x99fefefe))
      ),
      home: const SplashScreenView(),
    );
  }
}