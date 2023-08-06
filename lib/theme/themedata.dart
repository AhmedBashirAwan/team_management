import 'package:flutter/material.dart';

class ThemeDataRepository {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: const TextTheme(
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
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black,
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
    textTheme: const TextTheme(
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
    appBarTheme: const AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
  );
}
