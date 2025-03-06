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
      cardTheme: const CardTheme(shadowColor: spaceCadet, color: papayaWhip),
      dropdownMenuTheme: const DropdownMenuThemeData(
          inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: papayaWhip,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              )),
          menuStyle: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(papayaWhip),
          )),
      navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: caribeanCurrent,
          indicatorColor: caribeanCurrent,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          labelTextStyle: WidgetStatePropertyAll(TextStyle(
              color: papayaWhip, fontWeight: FontWeight.w400, fontSize: 12)),
          iconTheme: WidgetStatePropertyAll(
              IconThemeData(size: 36, color: papayaWhip))),
      dataTableTheme: const DataTableThemeData(
        dividerThickness: 2,
        headingRowColor: WidgetStatePropertyAll(papayaWhip),
        headingTextStyle: TextStyle(
          fontSize: 20,
        ),
        decoration: BoxDecoration(
          color: peach,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Colors.black26,
      ),
      listTileTheme: const ListTileThemeData(
        tileColor: papayaWhip,
      ),
      inputDecorationTheme: const InputDecorationTheme(
          filled: true, fillColor: Color(0x99fefefe)));
}
