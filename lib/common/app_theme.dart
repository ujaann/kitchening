import 'package:flutter/material.dart';
import 'package:kitchening/common/styles.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      scaffoldBackgroundColor: lightBrown,
      fontFamily: "Noto Sans",
      appBarTheme: const AppBarTheme(color: lightBlue),
      cardTheme: const CardTheme(shadowColor: ceramicGray),
      navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: lightBlue,
          indicatorColor: lightBrown,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          iconTheme: WidgetStatePropertyAll(
              IconThemeData(size: 36, color: Colors.blueGrey))),
      inputDecorationTheme: const InputDecorationTheme(
          filled: true, fillColor: Color(0x99fefefe)));
}
