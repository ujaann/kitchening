import 'package:flutter/material.dart';
import 'package:kitchening/common/styles.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      scaffoldBackgroundColor: lightBrown,
      fontFamily: "Noto Sans",
      appBarTheme: const AppBarTheme(color: lightBlue),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff9fbfdf),
        foregroundColor: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      )),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: lightBlue,
          splashColor: const Color(0xff9fbfdf),
          elevation: 2,
          iconSize: 40,
          foregroundColor: Colors.blueGrey[700]),
      //notworking
      cardColor: lightBlue,
      cardTheme: const CardTheme(shadowColor: ceramicGray, color: ceramicWhite),
      navigationBarTheme: NavigationBarThemeData(
          backgroundColor: lightBlue,
          indicatorColor: const Color(0xff9fbfdf),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          iconTheme: WidgetStatePropertyAll(
              IconThemeData(size: 36, color: Colors.blueGrey[700]))),
      inputDecorationTheme: const InputDecorationTheme(
          filled: true, fillColor: Color(0x99fefefe)));
}
