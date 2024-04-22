import 'package:flutter/material.dart';
import 'package:tawsela_app/constants.dart';

ThemeData darkTheme=ThemeData(
        brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF212121), // Dark background
    textTheme:  const TextTheme(
      displayLarge: TextStyle(fontSize: 30.0, color: Colors.red),
      displayMedium: TextStyle(fontSize: 24.0, color: Colors.red),
      displaySmall: TextStyle(fontSize: 20.0, color: Colors.red),
      headlineMedium: TextStyle(fontSize: 16.0, color: Colors.red),
      headlineSmall: TextStyle(fontSize: 14.0, color: Colors.red),
      titleLarge: TextStyle(fontSize: 12.0, color: Colors.red),
      bodyLarge: TextStyle(fontSize: 14.0, color: Colors.red),
      bodyMedium: TextStyle(fontSize: 12.0, color: Colors.red),
      titleMedium: TextStyle(fontSize: 16.0, color: Colors.red),
      titleSmall: TextStyle(fontSize: 12.0, color: Colors.red),
      labelLarge: TextStyle(fontSize: 14.0, color: Colors.red),
      bodySmall: TextStyle(fontSize: 11.0, color: Colors.red),
      labelSmall: TextStyle(fontSize: 10.0, color: Colors.red),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF212121), // Dark app bar background
      foregroundColor: Colors.white, // White text for better contrast
    ),
    primaryTextTheme: const TextTheme(
      headline1: TextStyle(fontSize: 30.0, color: Colors.red),
      // ... all other text styles with red color
    ),
);