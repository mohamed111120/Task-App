import 'package:auth/utils/app_help/app_colores.dart';
import 'package:flutter/material.dart';

ThemeData getLightTheme() {
  return ThemeData(
    primaryColor: AppColores.primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColores.primary,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: AppColores.primary,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: AppColores.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(
        color: AppColores.black,
        fontSize: 15,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColores.formField,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          width: 1,
          color: AppColores.primary,
        )
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            width: 1,
            color: AppColores.primary,
          )
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            width: 1,
            color: AppColores.primary,
          )
      ),

    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColores.primary,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColores.primary
    ),
  );
}

ThemeData getDarkTheme() {
  return ThemeData.dark();
}
