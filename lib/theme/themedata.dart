import 'package:flutter/material.dart';

class ThemeDataRepository {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: const TextTheme(
      titleSmall: TextStyle(
        fontFamily: 'Poppins',
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Poppins',
        color: Colors.black,
        fontSize: 26,
        fontWeight: FontWeight.w600,
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
          fontFamily: 'Poppins',
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500),
      titleMedium: TextStyle(
        color: Colors.white,
        fontFamily: 'Poppins',
        fontSize: 26,
        fontWeight: FontWeight.w600,
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
