import 'package:flutter/material.dart';

final ThemeData themeLight = ThemeData(
  accentColor: themeGreen[900],
  primaryColor: themeGreen,
  accentColorBrightness: Brightness.light,
  accentIconTheme: IconThemeData(color: themeGreen.shade50),
  brightness: Brightness.light,
  backgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textSelectionColor: themeGreen[300],
  primarySwatch: themeGreen,
);

const MaterialColor themeGreen = const MaterialColor(
  0xFF009245,
  const <int, Color>{
    50: const Color(0xFFD9FAE8),
    100: const Color(0xFFA7ECC7),
    200: const Color(0xFF51C185),
    300: const Color(0xFF89E7B5),
    400: const Color(0xFF59D693),
    500: const Color(0xFF38B672),
    600: const Color(0xFF12B05B),
    700: const Color(0xFF009245),
    800: const Color(0xFF00813C),
    900: const Color(0xFF004420),
  },
);
