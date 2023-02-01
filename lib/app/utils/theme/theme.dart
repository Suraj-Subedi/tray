import 'package:flutter/material.dart';

enum ThemeType {
  Light,
  Dark,
}

class AppTheme {
  static ThemeType defaultTheme = ThemeType.Dark;

  final bool isDark;
  final Color primaryColor;
  final Color accentColor;
  final Color backgroundColor;
  final Color textColor;

  AppTheme(
      {required this.isDark,
      required this.primaryColor,
      required this.accentColor,
      required this.backgroundColor,
      required this.textColor});

  factory AppTheme.fromType(ThemeType t) {
    switch (t) {
      case ThemeType.Light:
        return AppTheme(
          isDark: false,
          primaryColor: const Color.fromARGB(255, 10, 13, 80),
          accentColor: const Color.fromARGB(255, 27, 35, 174),
          backgroundColor: Colors.white,
          textColor: Colors.black,
        );
      case ThemeType.Dark:
        return AppTheme(
          isDark: true,
          primaryColor: const Color.fromARGB(255, 76, 96, 106),
          accentColor: const Color.fromARGB(255, 141, 160, 170),
          backgroundColor: const Color.fromARGB(255, 30, 30, 30),
          textColor: Colors.white,
        );
    }
  }

  ThemeData build() {
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primaryColor: primaryColor,
      backgroundColor: backgroundColor,
      textTheme: TextTheme(bodyText1: TextStyle(color: textColor)),
      colorScheme: ColorScheme(
        primary: primaryColor,
        // primaryVariant: accentColor,
        secondary: accentColor,
        // secondaryVariant: primaryColor,
        surface: backgroundColor,
        background: backgroundColor,
        error: Colors.red,
        onPrimary: textColor,
        onSecondary: textColor,
        onSurface: textColor,
        onBackground: textColor,
        onError: Colors.white,
        brightness: isDark ? Brightness.dark : Brightness.light,
      ),
    );
  }
}
