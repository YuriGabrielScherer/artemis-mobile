import 'package:flutter/material.dart';

class ThemeProvider {
  static ThemeData get light {
    return ThemeData(
      fontFamily: 'OpenSans',
      primarySwatch: Colors.blue,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue.shade900,
      ),
      textTheme: textTheme,
    );
  }

  static ThemeData get dark {
    return ThemeData(
      primarySwatch: Colors.blue,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue.shade900,
      ),
      fontFamily: 'OpenSans',
      textTheme: textTheme,
    );
  }

  static TextTheme get textTheme => const TextTheme(
        caption: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      );
}
