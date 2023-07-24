import 'package:flutter/material.dart';

class ThemeDataRepository {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.red,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blue,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: Colors.grey.withOpacity(0.1),
    ),
    textTheme: TextTheme(
      titleSmall: TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
      titleMedium: TextStyle(
        color: Colors.black,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    hintColor: Colors.white,
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all<Color>(Colors.grey),
      thumbColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: Colors.grey.withOpacity(0.1),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        overlayColor: MaterialStateProperty.all<Color>(Colors.black26),
      ),
    ),
    textTheme: TextTheme(
      titleSmall: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      titleMedium: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
