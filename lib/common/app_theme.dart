import 'package:flutter/material.dart';
import 'package:kitchening/common/styles.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      scaffoldBackgroundColor: lightBrown,
      fontFamily: "Noto Sans",
      inputDecorationTheme: const InputDecorationTheme(
          filled: true, fillColor: Color(0x99fefefe)));
}
