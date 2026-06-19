import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D32), brightness: Brightness.light),
  scaffoldBackgroundColor: const Color(0xFFF4FBF4),
  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Color(0xFFD2E8D2)),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  ),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF81C784), brightness: Brightness.dark),
  scaffoldBackgroundColor: const Color(0xFF0E1711),
  cardTheme: CardThemeData(
    color: const Color(0xFF17221A),
    elevation: 1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF17221A),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
  ),
);