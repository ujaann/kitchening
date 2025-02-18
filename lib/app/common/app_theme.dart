import 'package:flutter/material.dart';
import 'package:kitchening/app/common/styles.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      scaffoldBackgroundColor: peach,
      fontFamily: "Noto Sans",
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: spaceCadet),
      ),
      appBarTheme: const AppBarTheme(
          color: caribeanCurrent, foregroundColor: papayaWhip),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: caribeanCurrent,
        foregroundColor: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      )),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 20,
          letterSpacing: 1,
          fontWeight: FontWeight.w600,
        ),
        foregroundColor: spaceCadet,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: const BorderSide(color: caribeanCurrent, width: 2),
      )),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: caribeanCurrent,
          splashColor: caribeanCurrent,
          elevation: 2,
          iconSize: 40,
          foregroundColor: papayaWhip),
      //notworking
      cardColor: lightBlue,
      cardTheme: const CardTheme(shadowColor: ceramicGray, color: ceramicWhite),
      navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: caribeanCurrent,
          indicatorColor: caribeanCurrent,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          labelTextStyle: WidgetStatePropertyAll(
              TextStyle(color: papayaWhip, fontWeight: FontWeight.w600)),
          iconTheme: WidgetStatePropertyAll(
              IconThemeData(size: 36, color: papayaWhip))),
      inputDecorationTheme: const InputDecorationTheme(
          filled: true, fillColor: Color(0x99fefefe)));
}
