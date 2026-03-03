

import 'package:flutter/material.dart';
import 'package:freelancer_app/theme/AppColors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    // ⚪ Background White
    scaffoldBackgroundColor: Colors.white,

    // 🔵 Primary Blue
    primaryColor: AppColors.primaryStart,

    colorScheme: ColorScheme.light(
      primary: AppColors.primaryStart,
      secondary: AppColors.primaryEnd,
    ),

    // 🔵 AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: AppColors.primaryStart,
      ),
      titleTextStyle: TextStyle(
        color: AppColors.primaryStart,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),

    // 🔵 Bottom Navigation
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primaryStart,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),

    // 🔵 Floating Button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryStart,
      foregroundColor: Colors.white,
    ),

    // 🔵 Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryStart,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}